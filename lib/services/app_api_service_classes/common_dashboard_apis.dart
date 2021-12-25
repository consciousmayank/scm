import 'package:scm/enums/order_summary_api_type.dart';
import 'package:scm/model_classes/common_dashboard_order_info.dart';
import 'package:scm/model_classes/common_dashboard_ordered_brands.dart';
import 'package:scm/model_classes/common_dashboard_ordered_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/model_classes/order_summary_response.dart';
import 'package:scm/model_classes/parent_api_response.dart';
import 'package:scm/services/network/base_api.dart';

abstract class CommonDashBoardApisAbstractClass {
  Future<CommonDashboardOrderInfo> getOrderInfo();

  Future<List<CommonDashboardOrderedBrands>> getOrderedBrands(
      {required int pageSize});

  Future<List<CommonDashboardOrderedTypes>> getOrderedTypes(
      {required int pageSize});

  Future<OrderListResponse> getOrdersList({
    required int pageSize,
    required int pageNumber,
    required String status,
  });

  Future<OrderSummaryResponse> getOrderDetails({
    String? orderId,
  });

  Future<OrderSummaryResponse> acceptOrder({
    required String? orderId,
  });

  Future<OrderSummaryResponse> rejectOrder({required int? orderId});

  Future<OrderSummaryResponse> deliverOrder({
    required int? orderId,
    required String deliveryBy,
  });

  Future<List<String>> getOrderStatusList();
}

class CommonDashBoardApis extends BaseApi
    implements CommonDashBoardApisAbstractClass {
  @override
  Future<OrderSummaryResponse> getOrderDetails({String? orderId}) async {
    OrderSummaryResponse returningResponse = OrderSummaryResponse().empty();

    ParentApiResponse apiResponse = await apiService.performOrderApiOperation(
      orderApiType: OrderApiType.ORDER_DETAILS,
      orderId: orderId,
      pageNumber: 0,
      pageSize: 0,
    );

    if (filterResponse(apiResponse) != null) {
      returningResponse = OrderSummaryResponse.fromMap(
        apiResponse.response!.data,
      );
    }

    return returningResponse;
  }

  @override
  Future<CommonDashboardOrderInfo> getOrderInfo() async {
    CommonDashboardOrderInfo returingResponse =
        CommonDashboardOrderInfo().empty();

    ParentApiResponse apiResponse = await apiService.getOrderInfo();

    if (filterResponse(apiResponse) != null) {
      returingResponse = CommonDashboardOrderInfo.fromMap(
        apiResponse.response!.data,
      );
    }

    return returingResponse;
  }

  @override
  Future<List<CommonDashboardOrderedBrands>> getOrderedBrands(
      {required int pageSize}) async {
    List<CommonDashboardOrderedBrands> returingResponse = [];

    ParentApiResponse apiResponse = await apiService.getOrderedBrands(
      pageSize: pageSize,
    );

    if (filterResponse(apiResponse) != null) {
      var list = apiResponse.response!.data;

      for (var item in list) {
        returingResponse.add(CommonDashboardOrderedBrands.fromMap(item));
      }
    }

    return returingResponse;
  }

  @override
  Future<List<CommonDashboardOrderedTypes>> getOrderedTypes(
      {required int pageSize}) async {
    List<CommonDashboardOrderedTypes> returingResponse = [];

    ParentApiResponse apiResponse = await apiService.getOrderedTypes(
      pageSize: pageSize,
    );

    if (filterResponse(apiResponse) != null) {
      var list = apiResponse.response!.data;

      for (var item in list) {
        returingResponse.add(CommonDashboardOrderedTypes.fromMap(item));
      }
    }

    return returingResponse;
  }

  @override
  Future<OrderListResponse> getOrdersList({
    required int pageSize,
    required int pageNumber,
    required String status,
  }) async {
    OrderListResponse returingResponse = OrderListResponse().empty();

    ParentApiResponse apiResponse = await apiService.performOrderApiOperation(
      orderApiType: OrderApiType.ORDER_LIST,
      pageNumber: pageNumber,
      pageSize: pageSize,
      status: status,
    );

    if (filterResponse(apiResponse) != null) {
      returingResponse = OrderListResponse.fromMap(
        apiResponse.response!.data,
      );
    }

    return returingResponse;
  }

  @override
  Future<OrderSummaryResponse> acceptOrder({required String? orderId}) async {
    OrderSummaryResponse returningResponse = OrderSummaryResponse().empty();

    ParentApiResponse apiResponse = await apiService.performOrderApiOperation(
      orderApiType: OrderApiType.ACCEPT_ORDER,
      orderId: orderId,
    );

    if (filterResponse(apiResponse) != null) {
      returningResponse = OrderSummaryResponse.fromMap(
        apiResponse.response!.data,
      );
    }

    return returningResponse;
  }

  @override
  Future<OrderSummaryResponse> deliverOrder(
      {required int? orderId, required String deliveryBy}) async {
    OrderSummaryResponse returningResponse = OrderSummaryResponse().empty();

    ParentApiResponse apiResponse = await apiService.performOrderApiOperation(
        orderApiType: OrderApiType.DELIVER_ORDER,
        orderId: orderId.toString(),
        deliveredBy: deliveryBy);

    if (filterResponse(apiResponse) != null) {
      returningResponse = OrderSummaryResponse.fromMap(
        apiResponse.response!.data,
      );
    }

    return returningResponse;
  }

  @override
  Future<OrderSummaryResponse> rejectOrder({required int? orderId}) async {
    OrderSummaryResponse returningResponse = OrderSummaryResponse().empty();

    ParentApiResponse apiResponse = await apiService.performOrderApiOperation(
      orderApiType: OrderApiType.REJECT_ORDER,
      orderId: orderId.toString(),
    );

    if (filterResponse(apiResponse) != null) {
      returningResponse = OrderSummaryResponse.fromMap(
        apiResponse.response!.data,
      );
    }

    return returningResponse;
  }

  @override
  Future<List<String>> getOrderStatusList() async {
    ParentApiResponse apiResponse = await apiService.getOrderStatusList();
    List<String> statusListResponse = [];

    if (filterResponse(apiResponse, showSnackBar: true) != null) {
      var list = apiResponse.response!.data as List;

      list.forEach((element) {
        String status = element as String;
        statusListResponse.add(status);
      });
    }

    return statusListResponse;
  }
}
