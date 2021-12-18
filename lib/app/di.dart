import 'package:get_it/get_it.dart';
import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/services/app_api_service_classes/brand_apis.dart';
import 'package:scm/services/app_api_service_classes/login_apis.dart';
import 'package:scm/services/app_api_service_classes/pim_supervisor_dashboard_statistics_api.dart';
import 'package:scm/services/app_api_service_classes/product_api.dart';
import 'package:scm/services/network/api_service.dart';
import 'package:scm/services/network/dio_client.dart';
import 'package:stacked_services/stacked_services.dart';

final di = GetIt.instance;

void declareDependencies() {
  di.registerSingletonAsync<AppPreferences>(() async {
    final prefs = AppPreferences();
    await prefs.init();
    return prefs;
  });
  di.registerLazySingleton(() => DialogService());
  di.registerLazySingleton(() => NavigationService());
  di.registerLazySingleton(() => SnackbarService());
  di.registerLazySingleton(() => ApiService());
  di.registerLazySingleton(
    () => DioConfig(
      baseUrl: EnvironmentConfig.BASE_URL,
    ),
  );
  di.registerLazySingleton(() => LoginApi());
  di.registerLazySingleton(() => ProductApis());
  di.registerLazySingleton(() => BrandsApi());
  di.registerLazySingleton(() => PimSupervisorDashboardStatisticsApi());
  // locator.registerLazySingleton(() => DioConfig(baseUrl: config.baseUrl));
  // locator.registerLazySingleton(() => NotificationsConfig());
}
