// import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:hero/core/api/end_points.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/core/models/notification_model.dart';
import 'package:hero/core/models/settings_model.dart';
import 'package:hero/features/signup/models/register_model.dart';

import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../models/create_schedual_trip_model.dart';
import '../models/create_trip_model.dart';
import '../models/delete_user_model.dart';
import '../models/direction.dart';
import '../models/login_model.dart';
import '../models/place_details.dart';
import '../models/place_geocode.dart';
import '../models/signup_response_model.dart';
import '../preferences/preferences.dart';
import '../utils/app_strings.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, PlaceDatailsModel>> searchOnMapH(String inputType,String input,String fields)async{

    try{
      final response = await dio.get(
          EndPoints.googleBaseUrl,
          queryParameters: {
            "inputtype":inputType,
            "input":input,
            "fields":fields,
            "language":"ar",
            "key":AppStrings.mapKey,
          }
      );
      return Right(PlaceDatailsModel.fromJson(response));
    }on ServerException{
      return Left(ServerFailure());
    }
  }

//
  Future<Either<Failure, SignUpModel>> postRegister(RegisterModel registerModel,bool isSignUp) async {
    try {
      var image =  await MultipartFile.fromFile(registerModel.image.path);
      var response = await dio.post(

        isSignUp?  EndPoints.registerUrl:EndPoints.editProfileUrl,
        queryParameters: {
          "device_type":registerModel.deviceType,
          "token":registerModel.token,
        },
        formDataIsEnabled: true,
        body: {
          'name': registerModel.name,
          'email':registerModel.email,
          "phone":registerModel.phone,
          "birth":registerModel.birth,
          "type":registerModel.type,
          "img":image

        },
      );

        return Right(SignUpModel.fromJson(response));



    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // Future<Either<Failure, SignUpModel>> editProfile(RegisterModel registerModel)async{
  //   try {
  //     var image =  await MultipartFile.fromFile(registerModel.image.path);
  //     var response = await dio.post(
  //
  //       EndPoints.editProfileUrl,
  //       queryParameters: {
  //         "device_type":registerModel.deviceType,
  //         "token":registerModel.token,
  //       },
  //       formDataIsEnabled: true,
  //       body: {
  //         'name': registerModel.name,
  //         'email':registerModel.email,
  //         "phone":registerModel.phone,
  //         "birth":registerModel.birth,
  //         "type":registerModel.type,
  //         "img":image
  //
  //       },
  //     );
  //
  //     return Right(SignUpModel.fromJson(response));
  //
  //
  //
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }
//   //
//   // Future<Either<Failure, ServiceStoreModel>> postServiceStore(ServiceModel serviceModel) async {
//   //   LoginModel loginModel = await Preferences.instance.getUserModel();
//   //
//   //   try {
//   //     List<MultipartFile> images = [];
//   //     for (int i = 0; i < serviceModel.images.length; i++) {
//   //
//   //       var image =  await MultipartFile.fromFile(serviceModel.images[i]!.path)  ;
//   //       images.add(image);
//   //     }      List phones = [];
//   //     for(int i = 0 ; i<serviceModel.phones.length ; i++){
//   //       phones.add(serviceModel.phones[i]);
//   //     }
//   //     final response = await dio.post(
//   //       EndPoints.serviceStoreUrl,
//   //       formDataIsEnabled: true,
//   //       options: Options(
//   //         headers: {'Authorization': loginModel.data!.accessToken!},
//   //       ),
//   //       body: {
//   //         'name': serviceModel.name,
//   //         "category_id":serviceModel.category_id,
//   //         "sub_category_id":serviceModel.sub_category_id,
//   //         "city_id":serviceModel.cityId,
//   //         "phones[]": phones,
//   //         "details":serviceModel.details,
//   //         "logo": await MultipartFile.fromFile(serviceModel.logo.path),
//   //         "location":serviceModel.location,
//   //         "images[]":images,
//   //         "longitude":serviceModel.longitude,
//   //         "latitude":serviceModel.latitude,
//   //       },
//   //     );
//   //     return Right(ServiceStoreModel.fromJson(response));
//   //   } on ServerException {
//   //
//   //     return Left(ServerFailure());
//   //   }
//   // }
//
//   Future<Either<Failure,UpdatedModel >> edit(ServiceToUpdate serviceToUpdate,catId) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//
//     try {
//       List<MultipartFile> images = [];
//       for (int i = 0; i < serviceToUpdate.images!.length; i++) {
//
//         var image =  await MultipartFile.fromFile(serviceToUpdate.images?[i]!.path)  ;
//         images.add(image);
//       }      List phones = [];
//       for(int i = 0 ; i<serviceToUpdate.phones!.length ; i++){
//         phones.add(serviceToUpdate.phones?[i]);
//       }
//       final response = await dio.post(
//         EndPoints.editServicesUrl + catId.toString(),
//
//         formDataIsEnabled: true,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         body: {
//           'name': serviceToUpdate.name,
//           "category_id":serviceToUpdate.categoryId,
//          // "sub_category_id":1,
//           "phones[]": phones,
//           "details":serviceToUpdate.details,
//            "city_id":serviceToUpdate.cityId,
//           "longitude":serviceToUpdate.longitude,
//           "latitude":serviceToUpdate.latitude,
//           "logo": serviceToUpdate.logo,
//           "location":serviceToUpdate.location,
//           "images[]":images,
//         },
//       );
//       return Right(UpdatedModel.fromJson(response));
//     } on ServerException {
//
//       return Left(ServerFailure());
//     }
//   }
//

  Future<Either<Failure, DeleteModel>> logout(String token) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {

      final response = await dio.post(
        EndPoints.logoutUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
     queryParameters: {
          "token":token
     }
      );
      return Right(DeleteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, DeleteModel>> delete() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {

      final response = await dio.post(
        EndPoints.deleteUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(DeleteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

    Future<Either<Failure,SettingsModel>> getSettings()async{
    try{
      final response = await dio.get(
        EndPoints.settingsUrl
      );
      return Right(SettingsModel.fromJson(response));
    }on ServerException{
      return Left(ServerFailure());
    }
    }
//
//
//   Future<Either<Failure, LoginModel>> postEditProfile(
//       String name) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//
//     try {
//       final response = await dio.post(
//         EndPoints.updateProfileUrl,
//         options: Options(headers: {"Authorization":loginModel.data!.accessToken!}),
//         body: {
//           'name': name,
//           "phone":loginModel.data?.user?.phone,
//         },
//       );
//
//       return Right(LoginModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//
  Future<Either<Failure, LoginModel>> checkPhone(String phone, String phoneCode) async {
    try {
      final response = await dio.post(
        EndPoints.checkPhoneUrl,
        body: {
          'phone': phoneCode+phone,
        },
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SignUpModel>> login(String phone, String phoneCode,String deviceType,String token) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'phone': phoneCode+phone,
        },
        queryParameters: {
          "device_type":deviceType,
          "token":token
        },
      );
      return Right(SignUpModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure,HomeModel>> getHomeData()async{
     SignUpModel signUpModel = await Preferences.instance.getUserModel();
     try{
       final response = await dio.get(
           EndPoints.homeUrl,
         options: Options(
           headers: {'Authorization': signUpModel.data?.token},
         ),
       );
       return Right(HomeModel.fromJson(response));
     }on ServerException{
       return Left(ServerFailure());
     }
   }

  Future<Either<Failure,NotificationModel>> getNotification()async{
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try{
      final response = await dio.get(
        EndPoints.notificationUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(NotificationModel.fromJson(response));
    }on ServerException{
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, CreateTripModel>> createTrip({required String tripType,
    required String fromAddress , required double fromLng , required fromLat,
    String? toAddress , double? toLng , double? toLat}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {

      final response = await dio.post(
        EndPoints.createTripUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
        body: {
          "trip_type":tripType,
          "from_address":fromAddress,
          "from_long":fromLng,
          "from_lat":fromLat,
          "to_address":toAddress,
          "to_long":toLng,
          "to_lat":toLat

        }
      );
      return Right(CreateTripModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CreateScedualTripModel>> createScheduleTrip({required String tripType,
    required String fromAddress , required double fromLng , required fromLat,
    String? toAddress , double? toLng , double? toLat ,required String date ,
    required String time}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {

      final response = await dio.post(
          EndPoints.createScheduleTripUrl,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "trip_type":tripType,
            "from_address":fromAddress,
            "from_long":fromLng,
            "from_lat":fromLat,
            "to_address":toAddress,
            "to_long":toLng,
            "to_lat":toLat,
            "date": date ,
            "time": time ,

          }
      );
      return Right(CreateScedualTripModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
//
//   Future<Either<Failure, HomeModel>> homeData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.homeUrl,
//         options: Options(
//           headers: {'Authorization': loginModel.data?.accessToken!},
//         ),
//       );
//       return Right(HomeModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, CategoriesServicesModel>> servicesData(
//       int catId) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.servicesUrl + catId.toString(),
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(CategoriesServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//   Future<Either<Failure, UpdatedModel>> editService(
//       int catId,ServiceToUpdate serviceToUpdate) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//
//     try {
//
//       List<MultipartFile> images = [];
//       for (int i = 0; i < serviceToUpdate.images!.length; i++) {
//
//         var imageFile = serviceToUpdate.images![i];
//         if (imageFile.path.startsWith('http')) {
//           // This is a remote URL, so we need to download the image and save it locally before uploading it
//           var response = await http.get(Uri.parse(imageFile.path));
//           var bytes = response.bodyBytes;
//           var tempDir = await getTemporaryDirectory();
//           var filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//           await File(filePath).writeAsBytes(bytes);
//           var image = await MultipartFile.fromFile(filePath);
//           images.add(image);
//         } else {
//           // This is a local file, so we can create a MultipartFile object from it
//           var image = await MultipartFile.fromFile(imageFile.path);
//           images.add(image);
//         }
//       }
//       final response = await dio.post(
//         EndPoints.editServicesUrl + catId.toString(),
//
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         body: {
//           "name":serviceToUpdate.name,
//           "category_id":serviceToUpdate.categoryId,
//           "sub_category_id":serviceToUpdate.subCategoryId,
//           "phones[0]":serviceToUpdate.phones?[0],
//           "phones[1]":serviceToUpdate.phones?[1],
//           "details":serviceToUpdate.details,
//          // "logo":serviceToUpdate.logo,
//           //"logo": await MultipartFile.fromFile(serviceToUpdate.logo!),
//           "logo": !serviceToUpdate.logo!.path.startsWith("http")?await MultipartFile.fromFile(serviceToUpdate.logo!.path):null,
//           "location":serviceToUpdate.location,
//           "images[]":images,
//
//         }
//
//       );
//      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//       print(response);
//       return Right(UpdatedModel.fromJson(response));
//     } on ServerException {
//       print("erroooooor");
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, CategoriesServicesModel>> servicesSearchData(
//       int catId,searchKey) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.servicesUrl + catId.toString(),
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         queryParameters: {"search_key":searchKey}
//       );
//       return Right(CategoriesServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, FavoriteModel>>getFavoriteData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.favoriteUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(FavoriteModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
  Future<Either<Failure, PlaceDatailsModel>> searchOnMap(
    String inputtype,
    String input,
    String fields,
  ) async {
    try {
      final response = await dio.get(EndPoints.searchUrl, queryParameters: {
        "inputtype": inputtype,
        "input": input,
        "fields": fields,
        "language": "ar",
        "key": AppStrings.mapKey
      });
      return Right(PlaceDatailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GeoCodeModel>> getGeoData(String latlng,) async {
    try {
      final response = await dio.get(EndPoints.geocodeUrl, queryParameters: {
        "latlng": latlng,
        "language": "ar",
        "key": AppStrings.mapKey
      });
      return Right(GeoCodeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DirectionModel>> getDirection(
    String origin,
    String destination,
    String transit_mode,
  ) async {
    try {
      final response = await dio.get(EndPoints.directionUrl, queryParameters: {
        "origin": origin,
        "destination": destination,
        "transit_mode": transit_mode,
        "key": AppStrings.mapKey
      });
      return Right(DirectionModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
//
//   Future<Either<Failure, FavoriteModel>>getFavoriteSearchData(searchKey) async {
//
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.favoriteUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         queryParameters: {"search_key":searchKey}
//       );
//
//       return Right(FavoriteModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, MyServicesModel>>getMyServicesData() async {
//
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.myServicesUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(MyServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//
//   Future<Either<Failure, MyServicesModel>>getMyServicesSearchData(searchKey) async {
//
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//
//       final response = await dio.get(
//         EndPoints.myServicesUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//         queryParameters: {"search_key":searchKey}
//
//       );
//
//       return Right(MyServicesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   // Future<Either<Failure, NotificationModel>>getNotifications() async {
//   //
//   //   LoginModel loginModel = await Preferences.instance.getUserModel();
//   //   try {
//   //
//   //     final response = await dio.get(
//   //         EndPoints.notificationUrl ,
//   //         options: Options(
//   //           headers: {'Authorization': loginModel.data!.accessToken!},
//   //         ),
//   //
//   //
//   //     );
//   //
//   //     return Right(NotificationModel.fromJson(response));
//   //   } on ServerException {
//   //     return Left(ServerFailure());
//   //   }
//   // }
//   //
//
//
//
//   Future<Either<Failure, CategoriesModel>>getCategoriesData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.categoriesUrl ,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//       return Right(CategoriesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure, SettingModel>> getSettingData() async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
//     try {
//       final response = await dio.get(
//         EndPoints.settingUrl,
//         options: Options(
//           headers: {'Authorization': loginModel.data!.accessToken!},
//         ),
//       );
//
//       return Right(SettingModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
//
//   Future<Either<Failure,AddToFavouriteResponseModel>> addToFavourite(serviceId) async {
//     LoginModel loginModel = await Preferences.instance.getUserModel();
// try{
//
//   final response = await dio.post(
//       EndPoints.addToFavouriteUrl,
//       options: Options(
//         headers: {"Authorization":loginModel.data!.accessToken},
//       ),
//       body: {"service_id":serviceId}
//   );
//   return Right(AddToFavouriteResponseModel.fromJson(response));
// } on ServerException{
//   return Left(ServerFailure());
// }
//   }

// Future<Either<Failure, SearchModel>> search(searchKey) async {
//   LoginModel loginModel = await Preferences.instance.getUserModel();
//
//   try {
//     final response = await dio.get(
//       EndPoints.searchUrl+searchKey,
//       options: Options(
//         headers: {'Authorization': loginModel.data!.accessToken!},
//       ),
//     );
//     return Right(SearchModel.fromJson(response));
//   } on ServerException {
//     return Left(ServerFailure());
//   }
// }
}
