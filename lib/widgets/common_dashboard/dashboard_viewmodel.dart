import 'dart:developer';

import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/model_classes/common_dashboard_order_info.dart';
import 'package:scm/model_classes/common_dashboard_ordered_brands.dart';
import 'package:scm/model_classes/common_dashboard_ordered_types.dart';
import 'package:scm/model_classes/order_list_response.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/widgets/common_dashboard/dashboard_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CommonDashboardViewModel extends GeneralisedBaseViewModel {
  late final CommonDashboardViewArguments arguments;
  CommonDashboardOrderInfo orderInfo = CommonDashboardOrderInfo().empty();
  ApiStatus orderInfoApi = ApiStatus.LOADING,
      orderedBrandsApi = ApiStatus.LOADING,
      orderedTypesApi = ApiStatus.LOADING,
      orderListApi = ApiStatus.LOADING;

  OrderListResponse orderList = OrderListResponse().empty();
  List<CommonDashboardOrderedBrands> orderedBrands = [];
  List<charts.Series<CommonDashboardOrderedBrands, String>>
      orderedBrandsBarData = [];

  List<CommonDashboardOrderedTypes> orderedTypes = [];
  List<charts.Series<CommonDashboardOrderedTypes, String>> orderedTypesBarData =
      [];

  int pageNumber = 0;
  int pageSize = 5;

  final CommonDashBoardApis _commonDashBoardApis = di<CommonDashBoardApis>();

  init({required CommonDashboardViewArguments args}) {
    arguments = args;

    getOrderInfo();
    getOrderedBrands();
    getOrderedTypes();
    getOrdereList();
  }

  getOrderInfo() async {
    orderInfo = await _commonDashBoardApis.getOrderInfo();
    orderInfoApi = ApiStatus.FETCHED;
    notifyListeners();
  }

  getOrderedBrands() async {
    orderedBrands = await _commonDashBoardApis.getOrderedBrands(
      pageSize: pageSize,
    );

    orderedBrandsBarData = [
      charts.Series(
        id: 'Ordered Brands',
        data: orderedBrands,
        insideLabelStyleAccessorFn: (CommonDashboardOrderedBrands series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (CommonDashboardOrderedBrands series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (CommonDashboardOrderedBrands series, _) => series.brand!,
        measureFn: (CommonDashboardOrderedBrands series, _) => series.count,
        colorFn: (CommonDashboardOrderedBrands series, _) =>
            charts.ColorUtil.fromDartColor(AppColors().primaryColor.shade200),
        labelAccessorFn: (CommonDashboardOrderedBrands series, _) =>
            series.count.toString(),
      ),
    ];
    orderedBrandsApi = ApiStatus.FETCHED;
    notifyListeners();
  }

  getOrderedTypes() async {
    orderedTypes = await _commonDashBoardApis.getOrderedTypes(
      pageSize: pageSize,
    );
    orderedTypesBarData = [
      charts.Series(
        id: 'Ordered Brands',
        data: orderedTypes,
        insideLabelStyleAccessorFn: (CommonDashboardOrderedTypes series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.white),
        outsideLabelStyleAccessorFn: (CommonDashboardOrderedTypes series, _) =>
            const charts.TextStyleSpec(fontSize: 10, color: charts.Color.black),
        domainFn: (CommonDashboardOrderedTypes series, _) => series.type!,
        measureFn: (CommonDashboardOrderedTypes series, _) => series.count,
        colorFn: (CommonDashboardOrderedTypes series, _) =>
            charts.ColorUtil.fromDartColor(AppColors().primaryColor.shade200),
        labelAccessorFn: (CommonDashboardOrderedTypes series, _) =>
            series.count.toString(),
      ),
    ];
    orderedTypesApi = ApiStatus.FETCHED;
    notifyListeners();
  }

  getOrdereList() async {
    orderList = await _commonDashBoardApis.getOrdersList(
      pageSize: pageSize + 5,
      pageNumber: 0,
      status: '',
    );
    orderListApi = ApiStatus.FETCHED;
    notifyListeners();
  }
}
