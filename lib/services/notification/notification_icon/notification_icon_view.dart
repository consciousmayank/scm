import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/appcolors.dart';
import 'package:scm/app/app.locator.dart';
import 'package:scm/app/image_config.dart';
import 'package:scm/enums/snackbar_types.dart';
import 'package:scm/services/notification/notification_icon/notification_icon_viewmodel.dart';
import 'package:scm/widgets/lottie_animation_widget.dart';
import 'package:scm/widgets/nullable_text_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationIconView extends StatelessWidget {
  const NotificationIconView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final NotificationIconViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationIconViewModel>.reactive(
      builder: (context, model, child) => InkWell(
        onTap: () {
          if (model.appNotificationsList.isNotEmpty) {
            model.takeToAppNotificationsList();
          } else {
            locator<SnackbarService>().showCustomSnackBar(
              variant: SnackbarType.ERROR,
              duration: const Duration(
                seconds: 4,
              ),
              title: "Error",
              message: 'No notifications found',
            );
          }
        },
        child: Column(
          children: [
            // Container(
            //   // padding: const EdgeInsets.symmetric(
            //   //   horizontal: 2,
            //   // ),
            //   child: NullableTextWidget.int(
            //     intValue: model.appNotificationsList.length,
            //     textStyle: Theme.of(context).textTheme.button!.copyWith(
            //           color: AppColors().white,
            //         ),
            //   ),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Theme.of(context).colorScheme.background,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: LottieStopAnimation(
                args: LottieStopAnimationArgs(
                  animation: notificationsAnimation,
                  height: 50,
                  width: 50,
                  showBg: false,
                  repeatAnimation: model.isNotificationsUnread(),
                ),
              ),
            ),
            //   DefaultTextStyle(
            //     style: GoogleFonts.openSans(
            //       fontSize: getValueForScreenType(
            //         context: context,
            //         mobile: 14,
            //         tablet: 16,
            //         desktop: 18,
            //       ),
            //       color: AppColors().white,
            //     ),
            //     child: AnimatedTextKit(
            //       repeatForever: true,
            //       animatedTexts: model.isNotificationsUnread()
            //           ? [
            //               ScaleAnimatedText('You'),
            //               ScaleAnimatedText('got'),
            //               ScaleAnimatedText('Notif.'),
            //             ]
            //           : [],
            //       isRepeatingAnimation: model.isNotificationsUnread(),
            //     ),
            //   ),
          ],
        ),
      ),
      viewModelBuilder: () => NotificationIconViewModel(),
    );
  }
}

class NotificationIconViewArguments {}
