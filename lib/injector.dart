import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hero/core/remote/service.dart';

import 'package:hero/features/login/cubit/login_cubit.dart';
import 'package:hero/features/my_wallet/cubit/my_wallet_cubit.dart';
import 'package:hero/features/notification/cubit/cubit/orders_cubit.dart';
import 'package:hero/features/profits/cubit/profits_cubit.dart';
import 'package:hero/features/requestlocation/cubit/request_location_cubit.dart';
import 'package:hero/features/signup/cubit/signup_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'features/bike_details/cubit/bike_details_cubit.dart';
import 'features/documents/cubit/upload_documents_cubit.dart';
import 'features/edit_profile/cubit/edit_profile_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/homedriver/cubit/home_driver_cubit.dart';
import 'features/trip_details/cubit/trip_details_cubit.dart';

// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////
  //
  serviceLocator.registerFactory(
    () => SplashCubit(
        // serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
    () => HomeDriverCubit(
         serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
    () => OrdersCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => LoginCubit(
     serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SignupCubit(
       serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => RequestLocationCubit(
     // serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => HomeCubit(
      serviceLocator(),
    ),
   );
  serviceLocator.registerFactory(
    () => EditProfileCubit(
      serviceLocator(),
    ),
   );
  serviceLocator.registerFactory(
    () => TripDetailsCubit(
      serviceLocator(),
    ),
   );
  serviceLocator.registerFactory(
    () => BikeDetailsCubit(
      serviceLocator(),
    ),
   );

  serviceLocator.registerFactory(
    () => UploadDocumentsCubit(
      serviceLocator(),
    ),
   );
 serviceLocator.registerFactory(
    () => MyWalletCubit(
      serviceLocator(),
    ),
   );serviceLocator.registerFactory(
    () => ProfitsCubit(
      serviceLocator(),
    ),
   );


  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}

class SplashCubit {
}
