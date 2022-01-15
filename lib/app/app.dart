import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/demand_module_landing_page_view.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_view.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/screens/pim_homescreen/pim_homescreen_view.dart';
import 'package:scm/screens/splash/splash_view.dart';
import 'package:scm/screens/supply_module_screens/supply_module_landing_page_view.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_view.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';
import 'package:stacked/stacked_annotations.dart';

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
  ],
  logger: StackedLogger(),
  // dependencies: [
  //   Presolve(
  //     classType: SharedPreferencesService,
  //     presolveUsing: SharedPreferencesService.getInstance,
  //   ),
  //   // LazySingleton(
  //   //     classType: ThemeService, resolveUsing: ThemeService.getInstance),
  //   // abstracted class type support
  //   LazySingleton(classType: ApiService),
  //   LazySingleton(classType: DialogService),
  //   LazySingleton(classType: NavigationService),
  //   LazySingleton(classType: SnackbarService),
  //   LazySingleton(classType: LoginApi),
  //   LazySingleton(classType: ProductApis),
  //   LazySingleton(classType: BrandsApi),
  //   LazySingleton(classType: PimSupervisorDashboardStatisticsApi),
  //   LazySingleton(classType: HomePageApisImpl),
  //   LazySingleton(classType: ProductCategoriesApiImpl),
  //   LazySingleton(classType: ProductListApiImpl),
  //   LazySingleton(classType: ProductBrandsApiImpl),
  //   LazySingleton(classType: ProductSubCategoriesApisImpl),
  //   LazySingleton(classType: CommonDashBoardApis),
  //   LazySingleton(classType: SuppliersListApi),
  //   LazySingleton(classType: DemandCartApi),
  //   LazySingleton(classType: ImageApi),
  //   LazySingleton(classType: CartStream),
  //   LazySingleton(classType: CatalogStream),
  //   LazySingleton(classType: NotificationsStream),
  //   LazySingleton(classType: AddressApis),
  //   LazySingleton(classType: SupplierCatalogApis),
  //   LazySingleton(classType: ProfileApisImpl),
  //   Singleton(classType: DioConfig),
  // ],
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}


//flutter pub run build_runner build --delete-conflicting-outputs