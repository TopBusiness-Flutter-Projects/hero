import 'package:dio/dio.dart';
import 'package:hero/core/api/end_points.dart';
import 'package:hero/core/models/cities_model.dart';
import 'package:hero/core/models/driver_data_model.dart';
import 'package:hero/core/models/end_quick_trip_model.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/core/models/notification_model.dart';
import 'package:hero/core/models/profit_model.dart';
import 'package:hero/core/models/settings_model.dart';
import 'package:hero/features/documents/screens/upload_documents.dart';
import 'package:hero/features/signup/models/register_model.dart';
import '../api/base_api_consumer.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import 'package:dartz/dartz.dart';
import '../models/add_favourite_model.dart';
import '../models/all_trips_model.dart';
import '../models/check_document_model.dart';
import '../models/check_trip_status_model.dart';
import '../models/create_schedual_trip_model.dart';
import '../models/create_trip_model.dart';
import '../models/delete_user_model.dart';
import '../models/direction.dart';
import '../models/driver_trips_model.dart';
import '../models/favourite_model.dart';
import '../models/login_model.dart';
import '../models/my_wallet_model.dart';
import '../models/place_details.dart';
import '../models/place_geocode.dart';
import '../models/rate_trip_model.dart';
import '../models/signup_response_model.dart';
import '../models/start_new_trip_model.dart';
import '../models/status_model.dart';
import '../models/store_bike_details_model.dart';
import '../models/store_driver_data_model.dart';
import '../preferences/preferences.dart';
import '../utils/app_strings.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, PlaceDatailsModel>> searchOnMapH(
      String inputType, String input, String fields) async {
    try {
      final response = await dio.get(EndPoints.googleBaseUrl, queryParameters: {
        "inputtype": inputType,
        "input": input,
        "fields": fields,
        "language": "ar",
        "key": AppStrings.mapKey,
      });
      return Right(PlaceDatailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

//
  Future<Either<Failure, SignUpModel>> postRegister(
      RegisterModel registerModel, bool isSignUp) async {
    try {
      if (registerModel.phone.startsWith("964")) {
        print("Before: ${registerModel.phone}");
        registerModel.phone = registerModel.phone.substring(3);
        print("After: ${registerModel.phone}");
      }

      var image = registerModel.image != null
          ? await MultipartFile.fromFile(registerModel.image!.path)
          : null;
      var response = await dio.post(
        isSignUp ? EndPoints.registerUrl : EndPoints.editProfileUrl,
        queryParameters: {
          "device_type": registerModel.deviceType,
          "token": registerModel.token
        },
        formDataIsEnabled: true,
        body: {
          'name': registerModel.name,
          'email': registerModel.email,
          "phone": registerModel.countryCode + registerModel.phone,
          "birth": registerModel.birth,
          "type": registerModel.type,
          "img": image
        },
      );
      return Right(SignUpModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  /////// Driver trips //////////////

  // start quick trip
  Future<Either<Failure, StartQuickTripModel>> startQuickTrip({
    required String fromAddress,
    required String fromLong,
    required String fromLat,
    required String toAddress,
    required String toLong,
    required String toLat,
    required String phone,
    required String name,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.startQuickTrip,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "from_address": fromAddress,
            "from_long": fromLong,
            "from_lat": fromLat,
            "to_address": toAddress,
            "to_long": toLong,
            "to_lat": toLat,
            "phone": phone,
            "name": name,
          });
      return Right(StartQuickTripModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // end quick trip
  Future<Either<Failure, EndQuickTripModel>> endQuickTrip({
    required String distance,
    required String time,
    required String phone,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.endQuickTrip,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "distance": distance,
            //"time": time,
            //"phone": phone,
           // "distance": '3',
            //"time": '30',
            "phone": phone,
          });
      return Right(EndQuickTripModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //////////// Trips //////
  //// Accept trip
  Future<Either<Failure, DriverTripsModel>> acceptTrip({
    required tripId,
    required lat,
    required long,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.acceptTrip,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "trip_id": tripId,
            "lat": lat,
            "long": long,
          });
      return Right(DriverTripsModel.fromJson(response));
    } on ServerException {
      print(ServerFailure());
      return Left(ServerFailure());
    }
  }

  //// Start trip
  Future<Either<Failure, DriverTripsModel>> startTrip({
    required String tripId, required String lat,
    required String long,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.startTrip,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "trip_id": tripId,
            "lat": lat,
            "long": long,
          });
      return Right(DriverTripsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //// Cancel trip
  Future<Either<Failure, DriverTripsModel>> cancelTrip({
    required String tripId,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.cancelTrip,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "trip_id": tripId,
          });
      return Right(DriverTripsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //// End trip
  Future<Either<Failure, DriverTripsModel>> endTrip({
    required String distance,
    //required String time,
    required String tripId,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.endTrip,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "distance": distance,
           // "time": time,
            "trip_id": tripId,
          });
      return Right(DriverTripsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

////////////////////////////////////////////////

// upload documents
  Future<Either<Failure, StoreBikeDetailsModel>> uploadDocuments(
      {String? agencyNumber,
      String? bikeLicense,
      String? idCard,
      String? houseCard,
      String? bikeImage,
      bool isUpdate = false}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();

    try {
      var response = await dio.post(
        isUpdate
            ? EndPoints.updateDriverDocument
            : EndPoints.storeDriverDocument,
        formDataIsEnabled: true,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
        body: {
          'agency_number': agencyNumber != null
              ? await MultipartFile.fromFile(agencyNumber)
              : null,
          'bike_license': bikeLicense != null
              ? await MultipartFile.fromFile(bikeLicense)
              : null,
          "id_card":
              idCard != null ? await MultipartFile.fromFile(idCard) : null,
          "house_card": houseCard != null
              ? await MultipartFile.fromFile(houseCard)
              : null,
          "bike_image": bikeImage != null
              ? await MultipartFile.fromFile(bikeImage)
              : null,
        },
      );
      return Right(StoreBikeDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SignUpModel>> editProfile(
      RegisterModel registerModel) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      var image = registerModel.image != null
          ? await MultipartFile.fromFile(registerModel.image!.path)
          : null;
      var response = await dio.post(
        EndPoints.editProfileUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
        formDataIsEnabled: true,
        body: {
          'name': registerModel.name,
          'email': registerModel.email,
          "phone": registerModel.countryCode + registerModel.phone,
          "birth": registerModel.birth,
          "type": registerModel.type,
          "img": image
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
//
//   Future<Either<Failure, DeleteModel>> logout(String token) async {
//     SignUpModel signUpModel = await Preferences.instance.getUserModel();
//     try {
//
//       final response = await dio.post(
//         EndPoints.logoutUrl,
//         options: Options(
//           headers: {'Authorization': signUpModel.data?.token},
//         ),
//      queryParameters: {
//           "token":token
//      }
//       );
//       return Right(DeleteModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

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

  // get cities
  Future<Either<Failure, CitiesModel>> getCities() async {
    try {
      final response = await dio.get(EndPoints.citiesUrl);
      return Right(CitiesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

// driver details

  Future<Either<Failure, StoreDriverDetailsModel>> addDriverDetails(
      {required String bikeType,
      required String bikeModel,
      required String bikeColor,
      required String areaId,
      bool isUpdate = false}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
          isUpdate
              ? EndPoints.updateDriverDetails
              : EndPoints.storeDriverDetails,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {
            "bike_type": bikeType,
            "bike_model": bikeModel,
            "bike_color": bikeColor,
            "area_id": areaId,
          });
      return Right(StoreDriverDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

//// check documents

  Future<Either<Failure, CheckStatusModel>> changeDriverStatus() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.changeDriverStatus,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(CheckStatusModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //// check documents

  Future<Either<Failure, CheckDocumentsModel>> checkDocuments() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.checkDocument,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(CheckDocumentsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

//// check documents

  Future<Either<Failure, MyWalletModel>> getWallet() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.driverWallet,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(MyWalletModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      final response = await dio.get(EndPoints.settingsUrl);
      return Right(SettingsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CheckTripStatusModel>> checkTripStatus() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();

    try {
      final response = await dio.get(EndPoints.getTripStatus,options: Options(
        headers: {'Authorization': signUpModel.data?.token},
      ),);
      return Right(CheckTripStatusModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AllTripsModel>> getAllTrips(
      {required String type, required bool isUser}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio
          .get(isUser ? EndPoints.allUserTripsUrl : EndPoints.allDriverTripsUrl,
              options: Options(
                headers: {'Authorization': signUpModel.data?.token},
              ),
              queryParameters: {"type": type});

      return Right(AllTripsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // driverProfit
  Future<Either<Failure, ProfitsModel>> getDriverProfit({
    required String type,
    String? from,
    String? to,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.driverProfit,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          queryParameters: {
            "type": type,
            "to": to,
            "from": from,
          });

      return Right(ProfitsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // driver data
  Future<Either<Failure, DriverDataModel>> getDriverData() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.getInfoDriver,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );

      return Right(DriverDataModel.fromJson(response));
    } on ServerException {
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
  Future<Either<Failure, LoginModel>> checkPhone(String phone) async {
    try {
      final RegExp regExp = RegExp(r'^964');
      if (regExp.hasMatch(phone)) {
        phone = phone.replaceFirst(regExp, '');
      }

      final response = await dio.post(
        EndPoints.checkPhoneUrl,

      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, RateModel>> rateUser({
    required String to,
    required String rate,
    required String description,
    required String tripId,
}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {

      final response = await dio.post(
        EndPoints.giveRateUrl,
        body: {
          'to': to,
          'rate': rate,
          'trip_id': tripId,
          'description': description,
        },
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),

      );
      return Right(RateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }




  Future<Either<Failure, RateModel>> giveRate(
      {
        required int tripId,
        required int to,
        required double rate,
        String? description}) async {
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    print("tripId = $tripId rate = $rate");
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.giveRateUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
        body: {
          'trip_id': "240",
          'rate': "2.5",
          'to': "143",
          'description': 'description'},
      );
      return Right(RateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SignUpModel>> login(
      String phone, String deviceType, String token) async {
    try {
      if (phone.startsWith("964")) {
        print("Before: ${phone}");
        phone = phone.substring(3);
        print("After: ${phone}");
      }

      print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
      print(AppStrings.countryCode + phone);
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'phone': AppStrings.countryCode + phone,
        },
        queryParameters: {"device_type": deviceType, "token": token},
      );
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
      print(response);
      return Right(SignUpModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, HomeModel>> getHomeData() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.homeUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(HomeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, NotificationModel>> getNotification() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.notificationUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(NotificationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DeleteModel>> deleteFavourite(int addressId) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.removeFavouriteUrl,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {"address_id": addressId});
      return Right(DeleteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AddFavouriteModel>> addFavourite(
      {required String address,
      required String lat,
      required String long}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.addFavouriteUrl,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          body: {"address": address, "lat": lat, "long": long});
      return Right(AddFavouriteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, FavouriteModel>> getFavourite() async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.favouriteUrl,
        options: Options(
          headers: {'Authorization': signUpModel.data?.token},
        ),
      );
      return Right(FavouriteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CreateTripModel>> createTrip(
      {required String tripType,
      required String fromAddress,
      required double fromLng,
      required fromLat,
      String? toAddress,
      double? toLng,
      double? toLat}) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.createTripUrl,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          formDataIsEnabled: true,
          body: {
            "trip_type": tripType,
            "from_address": fromAddress,
            "from_long": fromLng,
            "from_lat": fromLat,
            "to_address": toAddress,
            "to_long": toLng,
            "to_lat": toLat
          });
      print("1111111111111111111111111111111111111111");
      print(response);
      return Right(CreateTripModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> cancelUserTrip({
    required int tripId,
  }) async {
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.cancelTripUrl,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          queryParameters: {"trip_id": tripId});
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CreateScedualTripModel>> createScheduleTrip(
      {required String tripType,
      required String fromAddress,
      required String fromLng,
      required String fromLat,
      String? toAddress,
      String? toLng,
      String? toLat,
      required String date,
      required String time}) async {
    print("55555555555555555555555555555555555555555");
    print("date = $date , time = $time");
    SignUpModel signUpModel = await Preferences.instance.getUserModel();
    print("token = ${signUpModel?.data?.token}");
    try {
      final response = await dio.post(EndPoints.createScheduleTripUrl,
          options: Options(
            headers: {'Authorization': signUpModel.data?.token},
          ),
          // formDataIsEnabled: true,
          body: {
            // "trip_type":tripType,
            "from_address": fromAddress,
            "from_long": fromLng,
            "from_lat": fromLat,
            "to_address": toAddress,
            "to_long": toLng,
            "to_lat": toLat,
            "date": date,
            "time": time,
          });
      print("666666666666666666666666666666666666666");
      print(response);
      return Right(CreateScedualTripModel.fromJson(response));
    } on ServerException {
      print("0000000000000000000000000000000000000000000");

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

  Future<Either<Failure, GeoCodeModel>> getGeoData(
    String latlng,
  ) async {
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

  /// USER

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
