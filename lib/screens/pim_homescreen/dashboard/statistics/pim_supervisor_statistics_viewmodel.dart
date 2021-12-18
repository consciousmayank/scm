import 'package:flutter/material.dart';

import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/model_classes/pim_supervisor_dashboard_statistics_response.dart';
import 'package:scm/services/app_api_service_classes/pim_supervisor_dashboard_statistics_api.dart';

class PimSupervisorStatisticsViewModel extends GeneralisedBaseViewModel {
  PimSupervisorDashboardStatisticsResponse statistics =
      PimSupervisorDashboardStatisticsResponse.empty();

  final PimSupervisorDashboardStatisticsApi
      _pimSupervisorDashboardStatisticsApi =
      di<PimSupervisorDashboardStatisticsApi>();

  void getStatistics() async {
    setBusy(true);
    statistics = await _pimSupervisorDashboardStatisticsApi.getStatistics();
    setBusy(false);
    notifyListeners();
  }

  Created getStatisticsGrandTotal() {
    return Created(
      brands: getTotal(
        statistics.created == null ? 0 : statistics.created!.brands ?? 0,
        statistics.processed == null ? 0 : statistics.processed!.brands ?? 0,
        statistics.published == null ? 0 : statistics.published!.brands ?? 0,
      ),
      products: getTotal(
        statistics.created == null ? 0 : statistics.created!.products ?? 0,
        statistics.processed == null ? 0 : statistics.processed!.products ?? 0,
        statistics.published == null ? 0 : statistics.published!.products ?? 0,
      ),
      types: getTotal(
        statistics.created == null ? 0 : statistics.created!.types ?? 0,
        statistics.processed == null ? 0 : statistics.processed!.types ?? 0,
        statistics.published == null ? 0 : statistics.published!.types ?? 0,
      ),
    );
  }

  getTotal(int i, int j, int k) {
    return i + j + k;
  }
}
