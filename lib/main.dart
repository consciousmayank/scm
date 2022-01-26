import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/app.router.dart';
import 'package:scm/app/apptheme.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/app/setup_snackbars.dart';
import 'package:scm/services/notification/notification_click.dart';
import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:scm/utils/strings.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/di.dart';
import 'firebase_options.dart';
import 'url_strategy.dart';

import 'services/notification/local_notification_service.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  RemoteNotificationParams notificationParams = RemoteNotificationParams(
    id: message.data['id'],
    screen: message.data['screen'],
    type: message.data['type'],
    title: message.notification?.title as String,
    body: message.notification?.body as String,
  );

  OnNotificationClick notificationClick = OnNotificationClick(
    notificationParams: notificationParams,
  );
  notificationClick.handle();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  declareDependencies();
  setupDialogUi();
  setupSnackbarUi();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  usePathUrlStrategy();
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(
      desktop: 1280,
      tablet: 700,
      watch: 50,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String token;

  @override
  void initState() {
    super.initState();
    // getPermission();
    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleRemoteMessage(message: message);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        handleRemoteMessage(message: message);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleRemoteMessage(message: message);
    });
  }

  void handleRemoteMessage({RemoteMessage? message}) {
    RemoteNotificationParams notificationParams = RemoteNotificationParams(
      id: message?.data['id'],
      screen: message?.data['screen'],
      type: message?.data['type'],
      title: message?.notification?.title as String,
      body: message?.notification?.body as String,
    );

    OnNotificationClick notificationClick = OnNotificationClick(
      notificationParams: notificationParams,
    );
    notificationClick.handle();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: FutureBuilder(
        future: locator.allReady(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              title: appName,
              theme: ApplicationTheme().getAppTheme(),
              debugShowCheckedModeBanner: false,
              navigatorKey: StackedService.navigatorKey,
              onGenerateRoute: StackedRouter().onGenerateRoute,

              // initialRoute: dashBoardPageRoute,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
