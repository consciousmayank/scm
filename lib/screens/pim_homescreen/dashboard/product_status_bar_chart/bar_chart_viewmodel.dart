import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:scm/enums/product_statuses.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/bar_chart_product_status_response.dart';
import 'package:scm/screens/pim_homescreen/dashboard/product_status_bar_chart/bar_chart_view.dart';
import 'package:scm/services/app_api_service_classes/pim_supervisor_dashboard_statistics_api.dart';

class BarChartBasedOnProductStatusesViewModel extends GeneralisedBaseViewModel {
  late final BarChartBasedOnProductStatusesViewArguments args;
  late ProductStatuses selectedProductStatus;
  List<charts.Series<BarChartProductsStatus, String>> seriesBarData = [];
  List<String> uniqueDates = [];

  final PimSupervisorDashboardStatisticsApi _dashboardStatisticsApi =
      di<PimSupervisorDashboardStatisticsApi>();

  init({required BarChartBasedOnProductStatusesViewArguments arguments}) {
    args = arguments;
    selectedProductStatus = arguments.productStatus;
    getBarChartData();
  }

  void getBarChartData() async {
    setBusy(true);
    List<BarChartProductsStatus> response =
        await _dashboardStatisticsApi.getBarChartBasedOnProductStatuses(
      productStatuses: selectedProductStatus,
    );

    response.forEach((element) {
      if (element.date != null) {
        if (!uniqueDates.contains(element.date)) {
          uniqueDates.add(element.date!);
        }
      }
    });
    // if (uniqueDates.length > 0) {
    //   chartDate = uniqueDates.first;
    // }

    seriesBarData = [
      charts.Series(
        id: 'Id Goes here',
        data: response,
        insideLabelStyleAccessorFn: (BarChartProductsStatus series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (BarChartProductsStatus series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (BarChartProductsStatus series, _) => series.date!,
        measureFn: (BarChartProductsStatus series, _) => series.count,
        colorFn: (BarChartProductsStatus series, _) =>
            charts.ColorUtil.fromDartColor(AppColors().primaryColor.shade200),
        labelAccessorFn: (BarChartProductsStatus series, _) =>
            series.count.toString(),
      ),
    ];
    setBusy(false);
    notifyListeners();
  }
}
