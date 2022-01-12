// import 'package:get_it/get_it.dart';
// import 'package:scm/app/appconfigs.dart';
// import 'package:scm/app/shared_preferences.dart';
// import 'package:scm/services/app_api_service_classes/address_apis.dart';
// import 'package:scm/services/app_api_service_classes/brand_apis.dart';
// import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
// import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
// import 'package:scm/services/app_api_service_classes/home_page_apis.dart';
// import 'package:scm/services/app_api_service_classes/image_api.dart';
// import 'package:scm/services/app_api_service_classes/login_apis.dart';
// import 'package:scm/services/app_api_service_classes/pim_supervisor_dashboard_statistics_api.dart';
// import 'package:scm/services/app_api_service_classes/product_api.dart';
// import 'package:scm/services/app_api_service_classes/product_brands_apis.dart';
// import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
// import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
// import 'package:scm/services/app_api_service_classes/product_sub_categories_apis.dart';
// import 'package:scm/services/app_api_service_classes/profile_apis.dart';
// import 'package:scm/services/app_api_service_classes/supplier_catalog_apis.dart';
// import 'package:scm/services/app_api_service_classes/suppliers_list_api.dart';
// import 'package:scm/services/network/api_service.dart';
// import 'package:scm/services/network/dio_client.dart';
// import 'package:scm/services/network/dio_interceptor.dart';
// import 'package:scm/services/network/image_dio_client.dart';
// import 'package:scm/services/streams/cart_stream.dart';
// import 'package:scm/services/streams/catalog_stream.dart';
// import 'package:scm/services/streams/notifications_stream.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:stacked_themes/stacked_themes.dart';

// final di = GetIt.instance;

// void declareDependencies() {
  // di.registerSingletonAsync<AppPreferences>(() async {
  //   final prefs = AppPreferences();
  //   await prefs.init();
  //   return prefs;
  // });
//   di.registerLazySingleton(() => DialogService());
//   di.registerLazySingleton(() => NavigationService());
//   di.registerLazySingleton(() => SnackbarService());
//   di.registerLazySingleton(() => ApiService());
//   di.registerLazySingleton(
//     () => DioConfig(
//       baseUrl: EnvironmentConfig.BASE_URL,
//     ),
//   );
//   di.registerLazySingleton(
//     () => ImageDioConfig(
//       baseUrl: EnvironmentConfig.BASE_URL.replaceAll('/scm', ''),
//     ),
//   );
//   di.registerLazySingleton(() => AppDioInterceptor());
//   di.registerLazySingleton(() => LoginApi());
//   di.registerLazySingleton(() => ProductApis());
//   di.registerLazySingleton(() => BrandsApi());
//   di.registerLazySingleton(() => PimSupervisorDashboardStatisticsApi());
//   di.registerLazySingleton(() => HomePageApisImpl());
//   di.registerLazySingleton(() => ProductCategoriesApiImpl());
//   di.registerLazySingleton(() => ProductListApiImpl());
//   di.registerLazySingleton(() => ProductBrandsApiImpl());
//   di.registerLazySingleton(() => ProductSubCategoriesApisImpl());
//   di.registerLazySingleton(() => CommonDashBoardApis());
//   di.registerLazySingleton(() => SuppliersListApi());
//   di.registerLazySingleton(() => DemandCartApi());
//   di.registerLazySingleton(() => ImageApi());
//   di.registerLazySingleton(() => CartStream());
//   di.registerLazySingleton(() => CatalogStream());
//   di.registerLazySingleton(() => NotificationsStream());
//   di.registerLazySingleton(() => AddressApis());
//   di.registerLazySingleton(() => SupplierCatalogApis());
//   di.registerLazySingleton(() => ProfileApisImpl());

// // or add it to your third_party_services_module if you’re using injectable
//   // locator.registerLazySingleton(() => DioConfig(baseUrl: config.baseUrl));
//   // locator.registerLazySingleton(() => NotificationsConfig());
// }
