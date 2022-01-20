import 'package:get_it/get_it.dart';
import 'package:scm/services/app_api_service_classes/address_apis.dart';
import 'package:scm/services/app_api_service_classes/brand_apis.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
import 'package:scm/services/app_api_service_classes/home_page_apis.dart';
import 'package:scm/services/app_api_service_classes/image_api.dart';
import 'package:scm/services/app_api_service_classes/login_apis.dart';
import 'package:scm/services/app_api_service_classes/pim_supervisor_dashboard_statistics_api.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';
import 'package:scm/services/app_api_service_classes/product_brands_apis.dart';
import 'package:scm/services/app_api_service_classes/product_categories_apis.dart';
import 'package:scm/services/app_api_service_classes/product_list_apis.dart';
import 'package:scm/services/app_api_service_classes/product_sub_categories_apis.dart';
import 'package:scm/services/app_api_service_classes/profile_apis.dart';
import 'package:scm/services/app_api_service_classes/reports_apis.dart';
import 'package:scm/services/app_api_service_classes/supplier_catalog_apis.dart';
import 'package:scm/services/app_api_service_classes/suppliers_list_api.dart';
import 'package:scm/services/network/api_service.dart';
import 'package:scm/services/network/dio_client.dart';
import 'package:scm/services/network/dio_interceptor.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:scm/services/streams/cart_stream.dart';
import 'package:scm/services/streams/catalog_stream.dart';
import 'package:scm/services/streams/notifications_stream.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

void declareDependencies() {
  locator.registerSingletonAsync<AppPreferencesService>(() async {
    final prefs = AppPreferencesService();
    await prefs.init();
    return prefs;
  });
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => DioConfig());
  locator.registerLazySingleton(() => ApiServiceAppDioInterceptor());
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
  locator.registerLazySingleton(() => ReportsApi());

// or add it to your third_party_services_module if you’re using injectable
  // locator.registerLazySingleton(() => DioConfig(baseUrl: config.baseUrl));
  // locator.registerLazySingleton(() => NotificationsConfig());
}
