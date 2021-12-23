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
    String? orderId,
  });

  Future<OrderSummaryResponse> getOrderDetails({
    String? orderId,
  });
}

class CommonDashBoardApis extends BaseApi
    implements CommonDashBoardApisAbstractClass {
  @override
  Future<OrderSummaryResponse> getOrderDetails({String? orderId}) async {
    OrderSummaryResponse returningResponse = OrderSummaryResponse().empty();

    ParentApiResponse apiResponse = await apiService.getOrdersList(
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
    String? orderId,
  }) async {
    OrderListResponse returingResponse = OrderListResponse().empty();

    ParentApiResponse apiResponse = await apiService.getOrdersList(
      orderId: orderId,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    if (filterResponse(apiResponse) != null) {
      returingResponse = OrderListResponse.fromMap(
        apiResponse.response!.data,
      );
    }

    return returingResponse;
  }
}
