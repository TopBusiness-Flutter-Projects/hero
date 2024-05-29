import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hero/injector.dart' as injector;

import 'app.dart';
import 'app_bloc_observer.dart';
import 'config/routes/app_routes.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/restart_app_class.dart';
import 'firebase_options.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
int id = 0;
///Cloud messaging step 1
final navigatorKey = GlobalKey<NavigatorState>();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(channel.id, channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        icon: '@mipmap-mdpi/ic_launcher'));

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

  ///Cloud messaging step 2
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print(
        'on messsssssssssssdddssageeeeeeee${event.data.toString()}');
    print(
        'on messsssssssssssdddssageeeeeeee${event.notification!.body!.toString()}');
    showNotification(body: event.notification!.body!,title: event.notification!.title);
  });

  // Handle the onMessageOpenedApp event
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    navigatorKey.currentState?.pushNamed(Routes.notificationRoute);
  });


  ///////////////

const AndroidInitializationSettings initializationSettingsAndroid =
AndroidInitializationSettings('app_icon');

DarwinInitializationSettings initializationSettingsIOS =
const DarwinInitializationSettings(
  requestAlertPermission: true,
  requestBadgePermission: true,
  requestSoundPermission: true,
);

final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);





 await flutterLocalNotificationsPlugin.initialize(
   initializationSettings,
 // هنا بنقوله لما توصلك الاشعارات حتعمل ايه
   onDidReceiveNotificationResponse: (NotificationResponse details) async {
     navigatorKey.currentState?.pushNamed(Routes.notificationRoute);

     print('dddddddddddddddddddddddd');
     print(details.toString());
     print(details.payload.toString());
   },
 );
 if (Platform.isAndroid) {
   flutterLocalNotificationsPlugin
       .resolvePlatformSpecificImplementation<
       AndroidFlutterLocalNotificationsPlugin>()
       ?.requestNotificationsPermission();
 }
 if (Platform.isIOS) {
   flutterLocalNotificationsPlugin
       .resolvePlatformSpecificImplementation<
       IOSFlutterLocalNotificationsPlugin>()
       ?.requestPermissions(
     alert: true,
     badge: true,
     sound: true,
   );
 }
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

  ///////////////
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);
await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  alert: true,
  badge: true,
  sound: true,
);


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
///Cloud messaging step 3
///token used for identify user in databse
getToken() async {
  String? token = await messaging.getToken();
  print("token =  $token");

  Preferences.instance.setNotificationToken(value: token??'');
  return token;
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   await getNotiStatus();
//   print("Handling a background message: ${message.messageId}");
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(channel.id, channel.name,
//             channelDescription: channel.description,
//             icon: 'app_icon',
//           //  playSound: Preferences.instance.notiSound,
//          //   enableLights: Preferences.instance.notiLight,
//           //  enableVibration: Preferences.instance.notiVisbrate
//         ),
//       ),
//     );
//     navigatorKey.currentState?.pushNamed(Routes.notifications);
//   }
//
//   ///show notification
// }

final locator = GetIt.instance;

AndroidNotificationChannel channel = AndroidNotificationChannel(
  Preferences.instance.notiSound
      ? Preferences.instance.notiVisbrate
      ? Preferences.instance.notiLight
      ? 'high notiVisbrate'
      : 'high notiLight'
      : 'high notiSound'
      :
  "high notielse", // id
  Preferences.instance.notiSound
      ? Preferences.instance.notiVisbrate
      ? Preferences.instance.notiLight
      ? 'high_notiVisbrateTitle'
      : 'high_notiLightTitle'
      : 'high_notiSoundTitle'
      : "high_importance_channel_elm3", // title
  description: "this notification hero",
  importance: Importance.high,
  enableVibration: Preferences.instance.notiVisbrate,
  playSound: Preferences.instance.notiSound,
  enableLights: Preferences.instance.notiLight,
);

getNotiStatus() async {
  await Preferences.instance.getNotiLights().then((value) {
    Preferences.instance.notiLight = value!;
  });
  await Preferences.instance.getNotiSound().then((value) {
    Preferences.instance.notiSound = value!;
  });
  await Preferences.instance.getNotiVibrate().then((value) {
    Preferences.instance.notiVisbrate = value!;
  });
  print('+++++++++++++++++++++++++++++++');
  print(
      '++sound = ${Preferences.instance.notiSound}+++++/n++ visbrate = ${Preferences.instance.notiVisbrate}++++++++++++++++++++');
  print('+++++++++++++++++++++++++++++++');
}

