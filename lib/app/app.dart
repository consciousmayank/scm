import 'package:scm/app/appconfigs.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/demand_module_landing_page_view.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_view.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/screens/pim_homescreen/pim_homescreen_view.dart';
import 'package:scm/screens/splash/splash_view.dart';
import 'package:scm/screens/supply_module_screens/supply_module_landing_page_view.dart';
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
import 'package:scm/services/app_api_service_classes/supplier_catalog_apis.dart';
import 'package:scm/services/app_api_service_classes/suppliers_list_api.dart';
import 'package:scm/services/network/api_service.dart';
import 'package:scm/services/network/dio_client.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_view.dart';
import 'package:scm/services/streams/cart_stream.dart';
import 'package:scm/services/streams/catalog_stream.dart';
import 'package:scm/services/streams/notifications_stream.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_themes/stacked_themes.dart';

@StackedApp(
  routes: [
    MaterialRoute(path: mainViewRoute, page: SplashScreen, initial: true),
    MaterialRoute(path: logInPageRoute, page: LoginView),
    MaterialRoute(path: pimHomeScreenRoute, page: PimHomeScreenView),
    MaterialRoute(path: productListViewPageRoute, page: ProductListView),
    MaterialRoute(
        path: supplyLandingScreenRoute, page: SupplyModuleLandingPageView),
    MaterialRoute(
        path: demandLandingScreenRoute, page: DemandModuleLandingPageView),
    MaterialRoute(
        path: categoriesListViewPageRoute, page: PopularCategoriesView),
    MaterialRoute(path: brandsListViewPageRoute, page: PopularBrandsView),
    MaterialRoute(path: cartViewPageRoute, page: CartPageView),
    MaterialRoute(
        path: notificationScreenPageRoute, page: NotificationsScreenView),
    // CupertinoRoute(page: BottomNavExample),
    // CustomRouter(page: StreamCounterView, ),
    //Defines a route that defaults to using a PageRouteBuilder for custom route building functionality
  ],
  logger: StackedLogger(),
  dependencies: [
    LazySingleton(
        classType: ThemeService, resolveUsing: ThemeService.getInstance),
    // abstracted class type support
    LazySingleton(classType: ApiService),
    LazySingleton(classType: LoginApi),
    LazySingleton(classType: ProductApis),
    LazySingleton(classType: BrandsApi),
    LazySingleton(classType: PimSupervisorDashboardStatisticsApi),
    LazySingleton(classType: HomePageApisImpl),
    LazySingleton(classType: ProductCategoriesApiImpl),
    LazySingleton(classType: ProductListApiImpl),
    LazySingleton(classType: ProductBrandsApiImpl),
    LazySingleton(classType: ProductSubCategoriesApisImpl),
    LazySingleton(classType: CommonDashBoardApis),
    LazySingleton(classType: SuppliersListApi),
    LazySingleton(classType: DemandCartApi),
    LazySingleton(classType: ImageApi),
    LazySingleton(classType: CartStream),
    LazySingleton(classType: CatalogStream),
    LazySingleton(classType: NotificationsStream),
    LazySingleton(classType: AddressApis),
    LazySingleton(classType: SupplierCatalogApis),
    LazySingleton(classType: ProfileApisImpl),
    Singleton(classType: DioConfig),

    Presolve(
      classType: AppPreferences,
      presolveUsing: AppPreferences.getInstance,
    ),
  ],
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}


//flutter pub run build_runner build --delete-conflicting-outputs