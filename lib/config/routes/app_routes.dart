import 'package:flutter/material.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/features/documents/screens/upload_documents.dart';
import 'package:hero/features/home/screen/home.dart';
import 'package:hero/features/login/screens/login.dart';
import 'package:hero/features/login/screens/terms_conditions_screen.dart';
import 'package:hero/features/notification/screens/notification_screen.dart';
import 'package:hero/features/safety_rules/screens/safety_rules_screen.dart';
import 'package:hero/features/splash/screens/splash_screen.dart';
import 'package:hero/features/trip_details/screens/trip_details_screen.dart';
import '../../core/utils/app_strings.dart';
import '../../features/about_hero/screens/about_hero_screen.dart';
import '../../features/driver_signup/screens/driversignup.dart';
import '../../features/driver_waiting/screens/driver_waiting.dart';
import '../../features/edit_profile/screens/edit_profile_screen.dart';
import '../../features/favourite_locations/screens/favourite_locations_screen.dart';
import '../../features/hero_trip_policy/screens/hero_trip_policy_screen.dart';
import '../../features/homedriver/screen/home_driver.dart';
import '../../features/my_rewards/screens/my_rewards_screen.dart';
import '../../features/my_wallet/screens/my_wallet_screen.dart';
import '../../features/orders/creens/orders_screen.dart';
import '../../features/requestlocation/screens/requestlocation.dart';
import '../../features/signup/screens/signup.dart';
import '../../features/trip_service/screens/trip_insurance_service_screen.dart';
import '../../features/usertype/screens/usertype.dart';
import '../../features/verfication/verification.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String homedriverRoute = '/homedriver';
  //static const String notificationDetailsRoute = '/notificationDetails';
  static const String registerScreenRoute = '/registerScreen';
  static const String verificationScreenRoute = '/verificationScreen';
  static const String usertypeScreenRoute = '/userTypeScreen';
  static const String requestlocationScreenRoute = '/requestlocationScreen';
  static const String uploadDocumentsScreenRoute = '/uploadDocumentsScree';
  static const String driverwaitScreenRoute = '/driverwaitScreen';
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
  static const String driversignupRoute = '/driversignup';
  static const String notificationRoute = '/notification_screen';
  static const String tripDetailsRoute = '/trip_details_screen';
  static const String termsConditionsRoute = '/terms_conditions_screen';
  static const String safetyRulesScreen = '/safetyRulesScreen';
  static const String aboutHeroScreen = '/AboutHeroScreen';
  static const String heroTripPolicyScreen = '/HeroTripPolicyScreen';
  static const String tripInsuranceService = '/TripInsuranceService';
  static const String myRewardsScreen = '/MyRewardsScreen';
  static const String OrdersScreen = '/OrdersScreen';
  static const String MyWalletScreen = '/MyWalletScreen';

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
 case Routes.editProfileRoute:
   String type=settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>  EditProfileScreen(type: type),
        );
 case Routes.aboutHeroScreen:
        return MaterialPageRoute(
          builder: (context) => const AboutHeroScreen(),
        );
 case Routes.heroTripPolicyScreen:
        return MaterialPageRoute(
          builder: (context) => const HeroTripPolicyScreen(),
        ); case Routes.OrdersScreen:
        return MaterialPageRoute(
          builder: (context) => const OrdersScreen(),
        );
case Routes.MyWalletScreen:
        return MaterialPageRoute(
          builder: (context) => const MyWalletScreen(),
        );

 case Routes.favoriteRoute:
        return MaterialPageRoute(
          builder: (context) => const FavouriteLocationsScreen(),
        );


 case Routes.tripInsuranceService:
        return MaterialPageRoute(
          builder: (context) => const TripInsuranceService(),
        );case Routes.myRewardsScreen:
        return MaterialPageRoute(
          builder: (context) => const MyRewardsScreen(),
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
  // case Routes.registerScreenRoute:
  //   String type=settings.arguments as String;
  //
  //   return MaterialPageRoute(
  //         builder: (context) =>  SignUp(type: type,),
  //       );
      case Routes.registerScreenRoute:
        //String type=settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) =>  SignUp(),
        );
        case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) =>  Home(),
        );
        case Routes.homedriverRoute:
        return MaterialPageRoute(
          builder: (context) =>  HomeDriver(),
        );
      case Routes.driversignupRoute:
        return MaterialPageRoute(
          builder: (context) =>  DriverSignUp(),
        );
        case Routes.notificationRoute:
        return MaterialPageRoute(
          builder: (context) =>  NotificationScreen(),
        );
 case Routes.uploadDocumentsScreenRoute:
        return MaterialPageRoute(
          builder: (context) =>  UploadDocuments(),
        );
        case Routes.driverwaitScreenRoute:
        return MaterialPageRoute(
          builder: (context) =>  DriverWaiting(),
        );
      case Routes.termsConditionsRoute:
        return MaterialPageRoute(
          builder: (context) =>  TermsConditionsScreen(),
        );
        case Routes.safetyRulesScreen:
        return MaterialPageRoute(
          builder: (context) =>  SafetyRulesScreen(),
        );

      case Routes.tripDetailsRoute:
        final trip = settings.arguments as NewTrip;
        return MaterialPageRoute(
          builder: (context) =>  TripDetailsScreen(trip: trip),
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
