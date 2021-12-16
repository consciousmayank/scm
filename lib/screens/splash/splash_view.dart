import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/app/shared_preferences.dart';
import 'package:scm/enums/user_roles.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/utils/strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final preferences = di<AppPreferences>();

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

  loadNextPage() {
    String userSelectedRole = preferences.getSelectedUserRole();
    if (userSelectedRole.isNotEmpty &&
            userSelectedRole ==
                AuthenticatedUserRoles.ROLE_DEO.getStatusString ||
        userSelectedRole == AuthenticatedUserRoles.ROLE_SUPVR.getStatusString ||
        userSelectedRole == AuthenticatedUserRoles.ROLE_GD.getStatusString) {
      di<NavigationService>().replaceWith(pimHomeScreenRoute);
    } else {
      di<NavigationService>().replaceWith(logInPageRoute);
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
                  successAnimation,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = const Duration(
                        seconds: 2,
                      )
                      ..forward();

                    _controller.addStatusListener((status) {
                      loadNextPage();
                      // model.showInfoSnackBar(message: 'Load Next Page');
                    });
                  },
                ),
              ),
              DefaultTextStyle(
                style: GoogleFonts.arimaMadurai(
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
