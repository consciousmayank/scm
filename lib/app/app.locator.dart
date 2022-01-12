// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../services/app_api_service_classes/address_apis.dart';
import '../services/app_api_service_classes/brand_apis.dart';
import '../services/app_api_service_classes/common_dashboard_apis.dart';
import '../services/app_api_service_classes/demand_cart_api.dart';
import '../services/app_api_service_classes/home_page_apis.dart';
import '../services/app_api_service_classes/image_api.dart';
import '../services/app_api_service_classes/login_apis.dart';
import '../services/app_api_service_classes/pim_supervisor_dashboard_statistics_api.dart';
import '../services/app_api_service_classes/product_api.dart';
import '../services/app_api_service_classes/product_brands_apis.dart';
import '../services/app_api_service_classes/product_categories_apis.dart';
import '../services/app_api_service_classes/product_list_apis.dart';
import '../services/app_api_service_classes/product_sub_categories_apis.dart';
import '../services/app_api_service_classes/profile_apis.dart';
import '../services/app_api_service_classes/supplier_catalog_apis.dart';
import '../services/app_api_service_classes/suppliers_list_api.dart';
import '../services/network/api_service.dart';
import '../services/streams/cart_stream.dart';
import '../services/streams/catalog_stream.dart';
import '../services/streams/notifications_stream.dart';
import 'shared_preferences.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => ThemeService.getInstance());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => LoginApi());
  locator.registerLazySingleton(() => ProductApis());
  locator.registerLazySingleton(() => BrandsApi());
  locator.registerLazySingleton(() => PimSupervisorDashboardStatisticsApi());
  locator.registerLazySingleton(() => HomePageApisImpl());
  locator.registerLazySingleton(() => ProductCategoriesApiImpl());
  locator.registerLazySingleton(() => ProductListApiImpl());
  locator.registerLazySingleton(() => ProductBrandsApiImpl());
  locator.registerLazySingleton(() => ProductSubCategoriesApisImpl());
  locator.registerLazySingleton(() => CommonDashBoardApis());
  locator.registerLazySingleton(() => SuppliersListApi());
  locator.registerLazySingleton(() => DemandCartApi());
  locator.registerLazySingleton(() => ImageApi());
  locator.registerLazySingleton(() => CartStream());
  locator.registerLazySingleton(() => CatalogStream());
  locator.registerLazySingleton(() => NotificationsStream());
  locator.registerLazySingleton(() => AddressApis());
  locator.registerLazySingleton(() => SupplierCatalogApis());
  locator.registerLazySingleton(() => ProfileApisImpl());
  final appPreferences = await AppPreferences.getInstance();
  locator.registerSingleton(appPreferences);
}
