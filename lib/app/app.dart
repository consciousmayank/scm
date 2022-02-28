import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [],
  logger: StackedLogger(),
  // dependencies: [
  // Presolve(
  //   classType: SharedPreferencesService,
  //   presolveUsing: SharedPreferencesService.getInstance,
  // ),
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
