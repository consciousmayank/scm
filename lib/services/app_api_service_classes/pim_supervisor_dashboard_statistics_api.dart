import 'package:scm/enums/product_statuses.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/bar_chart_product_status_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/model_classes/pim_supervisor_dashboard_statistics_response.dart';
import 'package:scm/model_classes/statistics_product_created.dart';
import 'package:scm/services/network/base_api.dart';

abstract class PimSupervisorDashboardStatisticsAbstractClass {
  Future<PimSupervisorDashboardStatisticsResponse> getStatistics();

  Future<List<StatisticsProductsCreated>> getProductsCreatedStatistics(
      {String? selectedDate});

  Future<List<BarChartProductsStatus>> getBarChartBasedOnProductStatuses(
      {required ProductStatuses productStatuses});
}

class PimSupervisorDashboardStatisticsApi extends BaseApi
    implements PimSupervisorDashboardStatisticsAbstractClass {
  @override
  Future<List<BarChartProductsStatus>> getBarChartBasedOnProductStatuses(
      {required ProductStatuses productStatuses}) async {
    List<BarChartProductsStatus> returningResponse = [];

    ParentApiResponse apiResponse =
        await apiService.getBarChartBasedOnProductStatuses(
      productStatuses: productStatuses,
    );

    if (filterResponse(apiResponse) != null) {
      var list = apiResponse.response!.data as List;

      for (var item in list) {
        returningResponse.add(BarChartProductsStatus.fromMap(item));
      }
    }

    return returningResponse;
  }

  @override
  Future<List<StatisticsProductsCreated>> getProductsCreatedStatistics(
      {String? selectedDate}) async {
    List<StatisticsProductsCreated> productsCreatedStatistics = [];

    ParentApiResponse apiResponse =
        await apiService.getProductsCreatedStatistics(
      selectedDate: selectedDate,
    );

    if (filterResponse(apiResponse) != null) {
      var list = apiResponse.response!.data as List;

      for (var item in list) {
        productsCreatedStatistics.add(StatisticsProductsCreated.fromMap(item));
      }
    }

    return productsCreatedStatistics;
  }

  @override
  Future<PimSupervisorDashboardStatisticsResponse> getStatistics() async {
    PimSupervisorDashboardStatisticsResponse response =
        PimSupervisorDashboardStatisticsResponse.empty();

    ParentApiResponse apiResponse =
        await apiService.getPimSupervisorDashboardStatistics();

    if (filterResponse(apiResponse) != null) {
      response = PimSupervisorDashboardStatisticsResponse.fromMap(
          apiResponse.response!.data);
    }

    return response;
  }
}
