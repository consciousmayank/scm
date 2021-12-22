// import 'package:bml_driver/view_vehicle_pucc_list/view_vehicle_pucc_list_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/styles.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/screens/pim_homescreen/add_product/add_product_view.dart';
import 'package:scm/screens/pim_homescreen/pim_homescreen_view.dart';
import 'package:scm/screens/splash/splash_view.dart';
import 'package:scm/screens/supply_module_screens/supply_module_landing_page_view.dart';
import 'package:scm/widgets/popular_brands/popular_brands_view.dart';
import 'package:scm/widgets/product/product_list/product_list_view.dart';

import '../routes/routes_constants.dart';
import 'routes_constants.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainViewRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          // builder: (_) => PimHomeScreenView(
          //   arguments: PimHomeScreenViewArguments(),
          // ),
        );

      case logInPageRoute:
        return FadeRoute(
          page: BaseView(
            child: LoginView(
              arguments: LoginViewArguments(),
            ),
          ),
        );

      case pimHomeScreenRoute:
        return FadeRoute(
          page: BaseView(
            child: PimHomeScreenView(
              arguments: PimHomeScreenViewArguments(),
            ),
          ),
        );

      case supplyLandingScreenRoute:
        return FadeRoute(
          page: SupplyModuleLandingPageView(
            arguments: SupplyModuleLandingPageViewArguments(),
          ),
        );

      case productListViewPageRoute:
        ProductListViewArguments arguments =
            settings.arguments as ProductListViewArguments;
        return FadeRoute(
          page: ProductListView(
            arguments: arguments,
          ),
        );

      case brandsListViewPageRoute:
        PopularBrandsViewArguments arguments =
            settings.arguments as PopularBrandsViewArguments;
        return FadeRoute(
          page: PopularBrandsView(
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
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => child,
      tablet: (BuildContext context) => child,
      desktop: (BuildContext context) => child,
    );
  }
}

class NotSupportedFormFactorWidget extends StatelessWidget {
  const NotSupportedFormFactorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(
            getValueForScreenType(
              context: context,
              mobile: 16,
              tablet: 32,
            ),
          ),
          child: Text(
            'This Web App is not supported in this form factor. Please open it in a Web Browser.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ),
    );
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
