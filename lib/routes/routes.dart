import 'package:flutter/material.dart';
import 'package:scm/model_classes/login_reasons.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/screens/demand_module_screens/demand_module_landing_page_view.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_view.dart';
import 'package:scm/screens/demand_module_screens/supplier_profile/supplier_profile_view.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/screens/not_supported_screens/not_supportd_screens.dart';
import 'package:scm/screens/pim_homescreen/pim_homescreen_view.dart';
import 'package:scm/screens/reports/orders_report/order_report_view.dart';
import 'package:scm/screens/splash/splash_view.dart';
import 'package:scm/screens/supply_module_screens/supply_module_landing_page_view.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_view.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/popular_categories/popular_categories_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainViewRoute:
        LoginReasons? reasons;
        if (settings.arguments != null) {
          reasons = settings.arguments as LoginReasons;
        }
        return MaterialPageRoute(
          builder: (_) => SplashScreen(
            reasons: reasons,
          ),
          // builder: (_) => PimHomeScreenView(
          //   arguments: PimHomeScreenViewArguments(),
          // ),
        );

      case logInPageRoute:
        LoginViewArgs? args;
        if (settings.arguments != null) {
          args = settings.arguments as LoginViewArgs;
        }
        return FadeRoute(
          page: BaseView(
            child: LoginView(
              arguments: args,
            ),
          ),
        );

      case pimHomeScreenRoute:
        return FadeRoute(
          page: const BaseView(
            child: PimHomeScreenView(),
          ),
        );

      case supplyLandingScreenRoute:
        return FadeRoute(
          page: const SupplyModuleLandingPageView(),
        );

      case demandLandingScreenRoute:
        return FadeRoute(
          page: const DemandModuleLandingPageView(),
        );

      case productListViewPageRoute:
        ProductListViewArgs arguments =
            settings.arguments as ProductListViewArgs;
        return FadeRoute(
          page: ProductListView(
            arguments: arguments,
          ),
        );

      case brandsListViewPageRoute:
        PopularBrandsViewArgs arguments =
            settings.arguments as PopularBrandsViewArgs;
        return FadeRoute(
          page: PopularBrandsView(
            arguments: arguments,
          ),
        );
      case categoriesListViewPageRoute:
        PopularCategoriesViewArgs arguments =
            settings.arguments as PopularCategoriesViewArgs;
        return FadeRoute(
          page: PopularCategoriesView(
            arguments: arguments,
          ),
        );
      case cartViewPageRoute:
        return FadeRoute(
          page: const CartPageView(),
        );

      case notificationScreenPageRoute:
        NotificationsScreenArgs arguments =
            settings.arguments as NotificationsScreenArgs;
        return FadeRoute(
          page: NotificationsScreenView(
            arguments: arguments,
          ),
        );
      case orderReportsScreenPageRoute:
        OrderReportsViewArgs arguments =
            settings.arguments as OrderReportsViewArgs;
        return FadeRoute(
          page: OrderReportsView(
            arguments: arguments,
          ),
        );
      //To goto the supplier profile page, in a stand alone page. Without AppBar. Have to handle if asked to do that.
      case selectedSupplierScreenPageRoute:
        SuppplierProfileViewArguments arguments =
            settings.arguments as SuppplierProfileViewArguments;
        return FadeRoute(
          page: SuppplierProfileView(
            arguments: arguments,
          ),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('Please define page for  ${settings.name}')),
                ));
    }
  }
}

class BaseView extends StatelessWidget {
  const BaseView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget page;
}
