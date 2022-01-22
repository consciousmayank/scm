// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../model_classes/login_reasons.dart';
import '../screens/demand_module_screens/demand_module_landing_page_view.dart';
import '../screens/demand_module_screens/supplier_cart/full_cart/cart_page_view.dart';
import '../screens/login/login_view.dart';
import '../screens/pim_homescreen/pim_homescreen_view.dart';
import '../screens/reports/orders_report/order_report_view.dart';
import '../screens/splash/splash_view.dart';
import '../screens/supply_module_screens/supply_module_landing_page_view.dart';
import '../services/notification/notifications_list_view/notifications_list_view.dart';
import '../widgets/popular_brands/popular_brands_view.dart';
import '../widgets/popular_categories/popular_categories_view.dart';
import '../widgets/product/product_list/product_list_view.dart';

class Routes {
  static const all = <String>{
    splashScreen,
    loginView,
    pimHomeScreenView,
    productListView,
    supplyModuleLandingPageView,
    demandModuleLandingPageView,
    popularCategoriesView,
    popularBrandsView,
    cartPageView,
    orderReportsView,
    notificationsScreenView,
  };

  static const String cartPageView = '/cartView';
  static const String demandModuleLandingPageView = '/demand';
  static const String loginView = '/login';
  static const String notificationsScreenView = '/notifications';
  static const String orderReportsView = '/orderReports';
  static const String pimHomeScreenView = '/pimHome';
  static const String popularBrandsView = '/brandsList';
  static const String popularCategoriesView = '/categoriesList';
  static const String productListView = '/productList';
  static const String splashScreen = '/';
  static const String supplyModuleLandingPageView = '/supply';
}

class StackedRouter extends RouterBase {
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashScreen: (data) {
      var args = data.getArgs<SplashScreenArguments>(
        orElse: () => SplashScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(
          key: args.key,
          reasons: args.reasons,
        ),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(
          key: args.key,
          arguments: args.arguments,
        ),
        settings: data,
      );
    },
    PimHomeScreenView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PimHomeScreenView(),
        settings: data,
      );
    },
    ProductListView: (data) {
      var args = data.getArgs<ProductListViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProductListView(
          key: args.key,
          arguments: args.arguments,
        ),
        settings: data,
      );
    },
    SupplyModuleLandingPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SupplyModuleLandingPageView(),
        settings: data,
      );
    },
    DemandModuleLandingPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DemandModuleLandingPageView(),
        settings: data,
      );
    },
    PopularCategoriesView: (data) {
      var args = data.getArgs<PopularCategoriesViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PopularCategoriesView(
          key: args.key,
          arguments: args.arguments,
        ),
        settings: data,
      );
    },
    PopularBrandsView: (data) {
      var args = data.getArgs<PopularBrandsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PopularBrandsView(
          key: args.key,
          arguments: args.arguments,
        ),
        settings: data,
      );
    },
    CartPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CartPageView(),
        settings: data,
      );
    },
    OrderReportsView: (data) {
      var args = data.getArgs<OrderReportsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => OrderReportsView(
          key: args.key,
          arguments: args.arguments,
        ),
        settings: data,
      );
    },
    NotificationsScreenView: (data) {
      var args = data.getArgs<NotificationsScreenViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => NotificationsScreenView(
          key: args.key,
          arguments: args.arguments,
        ),
        settings: data,
      );
    },
  };

  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.pimHomeScreenView, page: PimHomeScreenView),
    RouteDef(Routes.productListView, page: ProductListView),
    RouteDef(Routes.supplyModuleLandingPageView,
        page: SupplyModuleLandingPageView),
    RouteDef(Routes.demandModuleLandingPageView,
        page: DemandModuleLandingPageView),
    RouteDef(Routes.popularCategoriesView, page: PopularCategoriesView),
    RouteDef(Routes.popularBrandsView, page: PopularBrandsView),
    RouteDef(Routes.cartPageView, page: CartPageView),
    RouteDef(Routes.orderReportsView, page: OrderReportsView),
    RouteDef(Routes.notificationsScreenView, page: NotificationsScreenView),
  ];

  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;

  @override
  List<RouteDef> get routes => _routes;
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SplashScreen arguments holder class
class SplashScreenArguments {
  SplashScreenArguments({this.key, this.reasons});

  final Key? key;
  final LoginReasons? reasons;
}

/// LoginView arguments holder class
class LoginViewArguments {
  LoginViewArguments({this.key, this.arguments});

  final LoginViewArgs? arguments;
  final Key? key;
}

/// ProductListView arguments holder class
class ProductListViewArguments {
  ProductListViewArguments({this.key, required this.arguments});

  final ProductListViewArgs arguments;
  final Key? key;
}

/// PopularCategoriesView arguments holder class
class PopularCategoriesViewArguments {
  PopularCategoriesViewArguments({this.key, required this.arguments});

  final PopularCategoriesViewArgs arguments;
  final Key? key;
}

/// PopularBrandsView arguments holder class
class PopularBrandsViewArguments {
  PopularBrandsViewArguments({this.key, required this.arguments});

  final PopularBrandsViewArgs arguments;
  final Key? key;
}

/// OrderReportsView arguments holder class
class OrderReportsViewArguments {
  OrderReportsViewArguments({this.key, required this.arguments});

  final OrderReportsViewArgs arguments;
  final Key? key;
}

/// NotificationsScreenView arguments holder class
class NotificationsScreenViewArguments {
  NotificationsScreenViewArguments({this.key, required this.arguments});

  final NotificationsScreenArgs arguments;
  final Key? key;
}
