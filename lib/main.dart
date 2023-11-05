import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/app.dart';
import 'package:hero/app_bloc_observer.dart';
import 'package:hero/core/utils/restart_app_class.dart';
import 'package:hero/injector.dart' as injector;
import 'package:flutter/services.dart';
import 'core/utils/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await injector.setup();
  Bloc.observer = AppBlocObserver();

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
    statusBarIconBrightness: Brightness.dark, // Set dark icons for light status bar color
  ));


}

