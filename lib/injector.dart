import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hero/core/remote/service.dart';
import 'package:hero/features/notification/cubit/cubit/orders_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/homedriver/screen/pages/home_map_driver/cubit/home_driver_cubit.dart';

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
     // serviceLocator(),
    ),
  );
  // serviceLocator.registerFactory(
  //       () => GoogleMapsCubit(
  //    // serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerFactory(
  //   () => ProfileCubit(
  //      serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerFactory(
  //   () => FavoriteCubit(
  //     serviceLocator(),
  //   ),
  // );
  serviceLocator.registerFactory(
    () => HomeCubit(
      serviceLocator(),
    ),

  // serviceLocator.registerFactory(
  //   () => PostsCubit(
  //     serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerFactory(
  //       () => EditProfileCubit(
  //     serviceLocator(),
  //   ),
  //
  // );
  // serviceLocator.registerFactory(
  //       () => MyPostsCubit(
  //     serviceLocator(),
  //   ),
  //
  // );
  // serviceLocator.registerFactory(
  //       () => AddServiceCubit(
  //     serviceLocator(),
  //   ),
  //
  // );
  // serviceLocator.registerFactory(
  //       () => DetailsCubit(
  //     serviceLocator(),
  //   ),
  //
  // );
  //
  // serviceLocator.registerFactory(
  //       () => PrivacyCubit(
  //     serviceLocator(),
  //   ),
  //
  // );
  // serviceLocator.registerFactory(
  //       () => ContactUsCubit(
  //     serviceLocator(),
  //   ),
  //
  // );
  // serviceLocator.registerFactory(
  //       () => NottificationCubit(
  //     serviceLocator(),
  //   ),
  //
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
