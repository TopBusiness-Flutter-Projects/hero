import 'dart:async';

import 'package:flutter/material.dart';

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
    Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.loginRoute,
              ModalRoute.withName(
                Routes.initialRoute,
              ),
            );
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('onBoarding') != null) {
    //   if (prefs.getString('user') != null) {
    //     if (context.read<SplashCubit>().adsList.isNotEmpty) {
    //       Navigator.pushReplacementNamed(context, Routes.podAdsPageScreenRoute,
    //           arguments: context.read<SplashCubit>().adsList.first);
    //     } else {
    //       Navigator.pushReplacementNamed(context, Routes.homePageScreenRoute);
    //     }
    //   } else {
    //     Navigator.pushNamedAndRemoveUntil(
    //       context,
    //       Routes.loginRoute,
    //       ModalRoute.withName(
    //         Routes.initialRoute,
    //       ),
    //     );
    //   }
    // } else {
    //   Navigator.pushReplacementNamed(
    //     context,
    //     Routes.onboardingPageScreenRoute,
    //   );
    // }
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
