import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>     with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 8, milliseconds: 500),
          () {
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getString('user') != null) {

          Navigator.pushReplacementNamed(context, Routes.homeRoute);

      }
      else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginRoute,
          ModalRoute.withName(
            Routes.initialRoute,
          ),
        );
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   Routes.loginRoute,
        //   ModalRoute.withName(
        //     Routes.initialRoute,
        //   ),
        // );
      }


  }

  @override
  void initState() {
    super.initState();
    // context.read<SplashCubit>().getAdsOfApp();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit:BoxFit.fill ,
          image: AssetImage(
            ImageAssets.splashImage,


          ),
        )),
        child:  Hero(
          tag: 'logo',
          child: SizedBox(
            child: Image.asset(
              ImageAssets.logoImage,
              // height: getSize(context) / 1.2,
              // width: getSize(context) / 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
