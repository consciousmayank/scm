import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/model_classes/app_notifications_helper.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_list_viewmodel.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_screen_desktop.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_screen_mobile.dart';
import 'package:scm/services/notification/notifications_list_view/notifications_screen_tablet.dart';
import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:stacked/stacked.dart';

class NotificationsScreenView extends StatefulWidget {
  const NotificationsScreenView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final NotificationsScreenArguments arguments;

  @override
  _NotificationsScreenViewState createState() =>
      _NotificationsScreenViewState();
}

class _NotificationsScreenViewState extends State<NotificationsScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsListViewModel>.reactive(
      onModelReady: (model) => model.init(args: widget.arguments),
      builder: (context, model, child) => ScreenTypeLayout(
        mobile: const NotificationsScreenMobile(),
        desktop: const NotificationsScreenDesktop(),
        tablet: const NotificationsScreenTablet(),
      ),
      viewModelBuilder: () => NotificationsListViewModel(),
    );
  }
}

class NotificationsScreenArguments {
  NotificationsScreenArguments.fromNotificationClick({
    required this.clickedNotification,
  }) : appNotificationsList = const [];

  NotificationsScreenArguments.fromNotificationIcon({
    required this.appNotificationsList,
  }) : clickedNotification = null;

  final List<AppNotificationsHelper> appNotificationsList;
  final AppNotificationsHelper? clickedNotification;
}
