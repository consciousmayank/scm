import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/app/apptheme.dart';
import 'package:scm/app/di.dart';
import 'package:scm/app/setup_dialogs_ui.dart';
import 'package:scm/app/setup_snackbars.dart';
import 'package:scm/routes/routes.dart';
import 'package:scm/routes/routes_constants.dart';
import 'package:scm/services/notification/notification_click.dart';
import 'package:scm/services/notification/remote_notification_params.dart';
import 'package:stacked_services/stacked_services.dart';
import 'firebase_options.dart';

import 'services/notification/local_notification_service.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  declareDependencies();
  setupDialogUi();
  setupSnackbarUi();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String token;

  final AppRouter _router = AppRouter();

  @override
  void initState() {
    super.initState();
    getPermission();
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
      screen: message?.data['screen'],
      type: message?.data['type'],
      title: message?.notification?.title,
      body: message?.notification?.body,
    );

    OnNotificationClick notificationClick = OnNotificationClick(
      notificationParams: notificationParams,
    );
    notificationClick.handle();
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      FirebaseMessaging.instance.getToken().then((value) {
        log("Token :: $value");
      });
    }

    log('User granted permission: ${settings.authorizationStatus}');
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
          future: di.allReady(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MaterialApp(
                theme: ThemeConfiguration().myTheme,
                debugShowCheckedModeBanner: false,
                navigatorKey: StackedService.navigatorKey,
                onGenerateRoute: _router.generateRoute,
                initialRoute: mainViewRoute,
                // initialRoute: dashBoardPageRoute,
              );
            } else {
              return const CircularProgressIndicator();

              // return LottieStopAnimation(
              //   args: LottieStopAnimationArgs(
              //     repeatAnimation: true,
              //     animation: splashAnimation,
              //   ),
              // );
            }
          }),
    );
  }
}
