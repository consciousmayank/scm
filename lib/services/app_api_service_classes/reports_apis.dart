import 'package:scm/model_classes/orders_report_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class ReportsApisAbstractClass {
  Future<OrdersReportResponse> getConsolidatedOrdersReport({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? selectedBrand,
    String? selectedType,
  });

  Future<OrdersReportResponse> getOrdersReportGroupByBrands({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? selectedBrand,
    String? selectedType,
  });

  Future<OrdersReportResponse> getOrdersReportGroupByTypes({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? selectedBrand,
    String? selectedType,
  });

  Future<OrdersReportResponse> getOrdersReportGroupBySubTypes({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? selectedBrand,
    String? selectedType,
  });
}

class ReportsApi extends BaseApi implements ReportsApisAbstractClass {
  @override
  Future<OrdersReportResponse> getConsolidatedOrdersReport({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? paramGroupBy,
    String? selectedBrand,
    String? selectedType,
  }) async {
    OrdersReportResponse? orderReportsApiResponse =
        OrdersReportResponse().empty();

    ParentApiResponse apiResponse = await apiService.getOrdersReport(
      dateFrom: dateFrom,
      dateTo: dateTo,
      pageNumber: pageNumber,
      pageSize: pageSize,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: paramGroupBy,
      selectedBrand: selectedBrand,
      selectedType: selectedType,
    );

    if (filterResponse(apiResponse, showSnackBar: false) != null) {
      orderReportsApiResponse = OrdersReportResponse.fromMap(
        apiResponse.response?.data,
      );
    }

    return orderReportsApiResponse;
  }

  @override
  Future<OrdersReportResponse> getOrdersReportGroupByBrands({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? selectedBrand,
    String? selectedType,
  }) {
    return getConsolidatedOrdersReport(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: dateFrom,
      dateTo: dateTo,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: 'brand',
      selectedBrand: selectedBrand,
      selectedType: selectedType,
    );
  }

  @override
  Future<OrdersReportResponse> getOrdersReportGroupBySubTypes({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? selectedBrand,
    String? selectedType,
  }) {
    return getConsolidatedOrdersReport(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: dateFrom,
      dateTo: dateTo,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: 'subType',
      selectedBrand: selectedBrand,
      selectedType: selectedType,
    );
  }

  @override
  Future<OrdersReportResponse> getOrdersReportGroupByTypes({
    required int pageNumber,
    required int pageSize,
    required String dateFrom,
    required String dateTo,
    required String selectedOrderStatus,
    String? selectedBrand,
    String? selectedType,
  }) {
    return getConsolidatedOrdersReport(
      pageNumber: pageNumber,
      pageSize: pageSize,
      dateFrom: dateFrom,
      dateTo: dateTo,
      selectedOrderStatus: selectedOrderStatus,
      paramGroupBy: 'type',
      selectedBrand: selectedBrand,
      selectedType: selectedType,
    );
  }
}
