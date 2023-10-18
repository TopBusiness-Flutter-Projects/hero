import 'package:flutter/material.dart';
import 'package:hero/features/home/screen/home.dart';
import 'package:hero/features/login/screens/login.dart';
import 'package:hero/features/splash/screens/splash_screen.dart';

import '../../core/utils/app_strings.dart';
import '../../features/requestlocation/screens/requestlocation.dart';
import '../../features/signup/screens/signup.dart';
import '../../features/usertype/screens/usertype.dart';
import '../../features/verfication/verification.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String notificationDetailsRoute = '/notificationDetails';
  static const String registerScreenRoute = '/registerScreen';
  static const String verificationScreenRoute = '/verificationScreen';
  static const String usertypeScreenRoute = '/userTypeScreen';
  static const String requestlocationScreenRoute = '/requestlocationScreen';
  static const String googleMapScreenRoute = '/googleMapScreen';
  static const String favoriteRoute = '/favorite';
  static const String fullScreenImageRoute = '/fullScreenImageRoute';
  static const String editProfileRoute = '/editProfile';
  static const String allServicesRoute = '/allServices';
  static const String privacyRoute = '/privacy_about';
  static const String myPostsRoute = '/my_posts';
  static const String detailsRoute = '/details';
  static const String contactUsRoute = '/contact_us';
  static const String googleMapDetailsRoute = '/google_map_details_screen';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ) ;
        case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
   case Routes.verificationScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const Verification(),
        );
        case Routes.usertypeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const ChooseType(),
        );
        case Routes.requestlocationScreenRoute:
          String type=settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>  RequestLocation(type: type,),
        );
  case Routes.registerScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const SignUp(),
        );
        case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) =>  Home(),
        );


      // case Routes.detailsRoute:
      //   final service = settings.arguments as ServicesModel;
      //   return MaterialPageRoute(
      //     // Extract the service model argument from the settings arguments map
      //
      //     builder: (context) => Details(service: service),
      //   );
      //


      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
