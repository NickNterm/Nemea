import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nemea/core/theme/custom_theme.dart';
import 'package:nemea/features/warnings/presentation/bloc/warnings/warnings_bloc.dart';

import 'app_config.dart';
import 'core/dependency_injection.dart';
import 'core/lang/language_cubit.dart';
import 'firebase_options.dart';
import 'utils/helpers/hive_helper.dart';
import 'package:logging/logging.dart';

import 'utils/route_generator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.data}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings(
        '@drawable/launch_background',
      ),
    ),
  );

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  //await flutterLocalNotificationsPlugin
  //    .resolvePlatformSpecificImplementation<
  //        AndroidFlutterLocalNotificationsPlugin>()
  //    ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  //RemoteNotification? notification = message.notification;
  //AndroidNotification? android = message.notification?.android;
  print("SHOWING NOTIFICATION!!!");

  try {
    flutterLocalNotificationsPlugin.show(
      Random().nextInt(100),
      message.data['title'],
      message.data['description'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          "0",
          "Announcement",
          //channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: '@drawable/launch_background',
        ),
      ),
      payload: 'data',
    );
  } catch (e) {
    print("this is a try catch");
    print(e);
  }
  print("should be done");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> mainApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await initGetIt();

  await HiveHelper.initHive();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("asdf");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
  });

  FirebaseMessaging.instance.subscribeToTopic('all');

  print('init logger');
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print('${event.level.name}: ${event.time}: ${event.message}');
  });

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => sl<LanguageCubit>()..getStartLang(),
        ),
        BlocProvider<WarningsBloc>(
          create: (context) => sl<WarningsBloc>(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('el'), Locale('en')],
        fallbackLocale: Locale('el'),
        path: 'assets/translations',
        startLocale: Locale('el'),
        child: BlocBuilder<LanguageCubit, Locale?>(
          builder: (context, state) {
            return MaterialApp(
              theme: AppTheme.lightTheme,
              initialRoute: FIRST_SCREEN,
              onGenerateRoute: RouteGenerator.generateRoute,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: state,
              navigatorKey: navigatorKey,
            );
          },
        ),
      ),
    ),
  );
}
