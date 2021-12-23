import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/work_summary_table_options.dart';
import 'package:scm/model_classes/statistics_product_created.dart';
import 'package:scm/services/app_api_service_classes/pim_supervisor_dashboard_statistics_api.dart';
import 'package:scm/utils/date_time_converter.dart';

class UserwiseProductsCreatedViewModel extends GeneralisedBaseViewModel {
  List<StatisticsProductsCreated> productsCreated = [];
  DateTime? selectedDate;

  final PimSupervisorDashboardStatisticsApi
      _pimSupervisorDashboardStatisticsApi =
      di<PimSupervisorDashboardStatisticsApi>();

  WorkSummaryTableOptions _workSummaryTableOptions =
      WorkSummaryTableOptions.OVER_ALL;

  WorkSummaryTableOptions get workSummaryTableOptions =>
      _workSummaryTableOptions;

  set workSummaryTableOptions(WorkSummaryTableOptions workSummaryTableOptions) {
    _workSummaryTableOptions = workSummaryTableOptions;
    switch (workSummaryTableOptions) {
      case WorkSummaryTableOptions.OVER_ALL:
        selectedDate = null;
        break;
      case WorkSummaryTableOptions.TODAY:
        selectedDate = DateTime.now();
        break;
      case WorkSummaryTableOptions.YESTERDAY:
        selectedDate = DateTime.now().subtract(
          const Duration(
            days: 1,
          ),
        );
        break;
      case WorkSummaryTableOptions.CUSTOM:
        break;
    }
    getProductsCreatedStatistics();
  }

  void getProductsCreatedStatistics() async {
    setBusy(true);
    productsCreated =
        await _pimSupervisorDashboardStatisticsApi.getProductsCreatedStatistics(
      selectedDate: selectedDate == null
          ? null
          : DateTimeToStringConverter.yyyymmdd(date: selectedDate!).convert(),
    );
    setBusy(false);
    notifyListeners();
  }
}
