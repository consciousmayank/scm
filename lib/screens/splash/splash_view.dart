import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/routes/routes_constants.dart';

import 'package:scm/app/app.router.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/app_themes_types.dart';
import 'package:scm/model_classes/login_reasons.dart';
import 'package:scm/screens/login/login_view.dart';
import 'package:scm/services/sharepreferences_service.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:scm/app/di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    this.reasons,
  }) : super(key: key);

  final LoginReasons? reasons;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final preferences = locator<AppPreferencesService>();

  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  loadNextPage({required BuildContext context}) {
    String userSelectedRole = preferences.getSelectedUserRole();
    if (loadProductEntryModule(userSelectedRole)) {
      // getThemeManager(context).selectThemeAtIndex(AppThemesType.PRIMARY_THEME.getValueIndex,);
      locator<NavigationService>().replaceWith(pimHomeScreenRoute);
    } else if (loadSupplyModule(userSelectedRole)) {
      // getThemeManager(context).selectThemeAtIndex(
      //   AppThemesType.SUPPLY_THEME.getValueIndex,
      // );
      locator<NavigationService>().replaceWith(supplyLandingScreenRoute);
    } else if (loadDemandModule(userSelectedRole)) {
      // getThemeManager(context).selectThemeAtIndex(
      //   AppThemesType.DEMAND_THEME.getValueIndex,
      // );
      locator<NavigationService>().replaceWith(demandLandingScreenRoute);
    } else {
      locator<NavigationService>().replaceWith(
        logInPageRoute,
        arguments: LoginViewArgs(
          reasons: widget.reasons,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors().white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width >
                        MediaQuery.of(context).size.height
                    ? MediaQuery.of(context).size.height / 2
                    : MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width >
                        MediaQuery.of(context).size.height
                    ? MediaQuery.of(context).size.height / 2
                    : MediaQuery.of(context).size.width / 2,
                child: Lottie.asset(
                  splashAnimation,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = const Duration(
                        seconds: 2,
                      )
                      ..forward();

                    _controller.addStatusListener((status) {
                      loadNextPage(context: context);
                      // model.showInfoSnackBar(message: 'Load Next Page');
                    });
                  },
                ),
              ),
              DefaultTextStyle(
                style: GoogleFonts.openSans(
                  fontSize: getValueForScreenType(
                    context: context,
                    mobile: 20,
                    tablet: 24,
                    desktop: 36,
                  ),
                  color: AppColors().black,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      appName,
                      speed: const Duration(
                        milliseconds: 100,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SplashScreenModel(),
    );
  }
}

class SplashScreenModel extends GeneralisedBaseViewModel {}
