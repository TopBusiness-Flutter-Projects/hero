import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/app.dart';
import 'package:hero/app_bloc_observer.dart';
import 'package:hero/core/utils/restart_app_class.dart';
import 'package:hero/injector.dart' as injector;
import 'package:flutter/services.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


FirebaseMessaging messaging = FirebaseMessaging.instance;
int id = 0;
///Cloud messaging step 1
final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(
      "Handling a background message: notificationn  ${message.notification.toString()}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await injector.setup();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// notification

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print(
        'on messsssssssssssdddssageeeeeeee${event.notification!.body!.toString()}');
    showNotification(body: event.notification!.body!,title: event.notification!.title);
  });

  // Handle the onMessageOpenedApp event
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
   // navigatorKey.currentState?.pushNamed(Routes.notifications);


  });
  getToken();


  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: true,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: HotRestartController(child: const HeroApp()),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.primary, // Set the desired status bar color
    statusBarIconBrightness:
        Brightness.dark, // Set dark icons for light status bar color
  ));
}
Future<void> showNotification({required String body, title}) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin
      .show(id++, title, body, notificationDetails, payload: 'item x');
}
getToken() async {
  String? token = await messaging.getToken();
  print("token =  $token");
  Preferences.instance.setNotificationToken(value: token??'');
  return token;
}