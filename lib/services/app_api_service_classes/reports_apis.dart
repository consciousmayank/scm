import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ReportsApisAbstractClass {
  Future<OrdersReportResponse?> getConsolidatedOrdersReport({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
  });

  Future<OrdersReportResponse?> getOrdersReportGroupByBrands({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
  });

  Future<OrdersReportResponse?> getOrdersReportGroupByTypes({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
  });

  Future<OrdersReportResponse?> getOrdersReportGroupBySubTypes({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
  });
}

class ReportsApi extends BaseApi implements ReportsApisAbstractClass {
  @override
  Future<OrdersReportResponse?> getConsolidatedOrdersReport({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? paramGroupBy,
  }) async {
    OrdersReportResponse? orderReportsApiResponse;

    ParentApiResponse apiResponse = await apiService.getOrdersReport(
      dateFrom: dateFrom,
      dateTo: dateTo,
      pageNumber: pageNumber,
      pageSize: pageSize,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: paramGroupBy,
    );

    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      orderReportsApiResponse = OrdersReportResponse.fromMap(
        apiResponse.response?.data,
      );
    }

    return orderReportsApiResponse;
  }

  @override
  Future<OrdersReportResponse?> getOrdersReportGroupByBrands(
      {required int pageNumber,
      required int pageSize,
      required String dateFrom,
      required String dateTo,
      required String selectedOrderStatus}) {
    return getConsolidatedOrdersReport(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: dateFrom,
      dateTo: dateTo,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: 'brand',
    );
  }

  @override
  Future<OrdersReportResponse?> getOrdersReportGroupBySubTypes(
      {required int pageNumber,
      required int pageSize,
      required String dateFrom,
      required String dateTo,
      required String selectedOrderStatus}) {
    return getConsolidatedOrdersReport(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: dateFrom,
      dateTo: dateTo,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: 'subType',
    );
  }

  @override
  Future<OrdersReportResponse?> getOrdersReportGroupByTypes(
      {required int pageNumber,
      required int pageSize,
      required String dateFrom,
      required String dateTo,
      required String selectedOrderStatus}) {
    return getConsolidatedOrdersReport(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: dateFrom,
      dateTo: dateTo,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: 'type',
    );
  }
}
