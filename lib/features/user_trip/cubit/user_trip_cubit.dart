import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/driver_trips_model.dart';
import '../../../core/models/end_quick_trip_model.dart';
import '../../../core/models/rate_trip_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/custom_marker.dart';
import '../../../core/utils/dialogs.dart';
import '../../orders/cubit/cubit/orders_cubit.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

part 'user_trip_state.dart';

class UserTripCubit extends Cubit<UserTripState> {
  List<LatLng> latLngList = [];
  List<LatLng> latLngListFromTo = [];
  List<mp.LatLng> point = [];
  List<mp.LatLng> pointFromTo = [];
  UserTripCubit(this.api) : super(DriverTripInitial()){
   // latLngList = [];
   // latLngListFromTo = [];
  }
  ServiceApi api;

  double rate = 0;
  TextEditingController commentController = TextEditingController();

  RateModel? rateTripModel;
  LatLng destinaion = LatLng(0, 0);
  LatLng strartlocation = LatLng(0, 0);

  // giveRate(
  //     {required int tripId,required int toId,
  //     String? description,
  //
  //     required BuildContext context}) async {
  //   emit(LoadingRatingState());
  //   final response = await api.giveRate(
  //
  //  //     tripId: tripId,
  //  //     rate: rate,
  //  //     description: description,
  //  // to: toId
  //       tripId: 129,
  //       rate: 2.5,
  //       description: 'description',
  //   to: 140
  //   );
  //   response.fold((l) {
  //     emit(RatingFailedState());
  //     Navigator.pop(context);
  //     errorGetBar("something wrong");
  //   }, (r) {
  //     if (r.code == 200 || r.code == 201) {
  //       Navigator.pop(context);
  //       rateTripModel = r;
  //       emit(RatingSuccessState());
  //       successGetBar(r.message);
  //     } else if (r.code == 500) {
  //       Navigator.pop(context);
  //       rateTripModel = r;
  //       emit(RatingSuccessState());
  //       successGetBar(r.message);
  //     } else {
  //       Navigator.pop(context);
  //       errorGetBar(r.message ?? "something iii wrong");
  //     }
  //
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, Routes.homedriverRoute, (route) => false);
  //
  //   });
  // }

  Set<Marker> markers = {};

  setMarkers(Marker source, Marker? destination) {
    markers.clear();
    markers.add(source);
    if (destination != null) {
      markers.add(destination);
    }

    emit(AddDetailsMarkersState());
  }

  BitmapDescriptor? bitmapDescriptorto;
  BitmapDescriptor? bitmapDescriptorfrom;

  setMarkerIcon(String to, LatLng currentLocation, LatLng destination) async {
    bitmapDescriptorto = await CustomeMarker(
      title: 'to'.tr(),
      location: to,
    ).toBitmapDescriptor().then((value) {
      bitmapDescriptorto = value;
      strartlocation =currentLocation;
      destinaion = destination;
      emit(RatingSuccessState());
      setMarkers(
        Marker(
          markerId: const MarkerId("currentLocation"),
          icon: bitmapDescriptorfrom!,
          position: LatLng(
              currentLocation?.latitude ?? 0, currentLocation?.longitude ?? 0),
        ),
        Marker(
          markerId: MarkerId("destination"),
          icon: value,
          position: destination,
        ),
      );
    });
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    double lat1 = radians(point1.latitude);
    double lon1 = radians(point1.longitude);
    double lat2 = radians(point2.latitude);
    double lon2 = radians(point2.longitude);

    // Haversine formula
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;
    double a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }
//////// GET direction

  String origin = "", dest = "";
  getDirection(LatLng startPosition, LatLng endPosition) async {

    origin = startPosition.latitude.toString() +
        "," +
        startPosition.longitude.toString();
    dest = endPosition.latitude.toString() +
        "," +
        endPosition.longitude.toString();
    final response = await api.getDirection(origin, dest, "bus");
    response.fold(
          (l) => emit(ErrorLocationSearch()),
          (r) {
        latLngList.clear();

        if (r.routes.length > 0) {
          point = mp.PolygonUtil.decode(
              r.routes.elementAt(0).overviewPolyline.points);
          latLngList =
              point.map((e) => LatLng(e.latitude, e.longitude)).toList();
        } else {
          latLngList = [];
        }
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);

        emit(UpdateDesitnationLocationState());
      },
    );
  }

  String originFrom = "", destTo = "";
  getDirectionFromTo(LatLng startPosition, LatLng endPosition) async {

    originFrom = startPosition.latitude.toString() +
        "," +
        startPosition.longitude.toString();
    destTo = endPosition.latitude.toString() +
        "," +
        endPosition.longitude.toString();
    final response = await api.getDirection(originFrom, destTo, "bus");
    response.fold(
          (l) => emit(ErrorLocationSearch()),
          (r) {
        latLngListFromTo.clear();

        if (r.routes.length > 0) {
          point = mp.PolygonUtil.decode(
              r.routes.elementAt(0).overviewPolyline.points);
          latLngListFromTo =
              point.map((e) => LatLng(e.latitude, e.longitude)).toList();
        } else {
          latLngListFromTo = [];
        }
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);

        emit(UpdateDesitnationLocationState());
      },
    );
  }





//   ///// Driver Trips ///////
// // accept trip
//   DriverTripsModel acceptTripModel = DriverTripsModel();
//
//   void acceptTrip(BuildContext context, String id) async {
//     emit(LoadingAcceptTripState());
//     AppWidget.createProgressDialog(context, "wait".tr());
//
//     final response = await api.acceptTrip(tripId: id);
//     print('ssssssssssss ${response.toString()}');
//
//     response.fold((l) {
//       Navigator.pop(context);
//       errorGetBar("error".tr());
//       emit(FailureAcceptTripState());
//     }, (r) {
//       if (r.data != null){
//         acceptTripModel = r;
//       successGetBar(r.message);
//       Navigator.pop(context);
//       //getStartStage();
//       emit(SuccessAcceptTripState());}
//       else{
//         Navigator.pop(context);
//         errorGetBar(r.message!);
//         emit(SuccessAcceptTripState());
//         Navigator.pop(context);
//         context.read<OrdersCubit>().getAllTrips("new",false);
//       }
//     });
//   }
//   // start trip
//   DriverTripsModel startTripModel = DriverTripsModel();
//   DateTime? startTime ;
//   void startTrip(BuildContext context, String id) async {
//     emit(LoadingStartTripState());
//     AppWidget.createProgressDialog(context, "wait".tr());
//
//     final response = await api.startTrip(tripId: id);
//
//     response.fold((l) {
//       Navigator.pop(context);
//       errorGetBar("error".tr());
//       emit(FailureStartTripState());
//     }, (r) {
//       startTripModel = r;
//       startTime = DateTime.now();
//       successGetBar(r.message);
// //getEndStage();
//       Navigator.pop(context);
//       emit(SuccessStartTripState());
//     });
//   }
//
//   DriverTripsModel cancelTripModel = DriverTripsModel();
//
//   void cancelTrip(BuildContext context, String id) async {
//     emit(LoadingCancelTripState());
//     AppWidget.createProgressDialog(context, "wait".tr());
//
//     final response = await api.cancelTrip(tripId: id);
//
//     response.fold((l) {
//       Navigator.pop(context);
//       errorGetBar("error".tr());
//       emit(FailureCancelTripState());
//     }, (r) {
//       cancelTripModel = r;
//       successGetBar(r.message);
//
//       Navigator.pop(context);
//
//
//
//
//       Navigator.pushNamedAndRemoveUntil(
//           context, Routes.homedriverRoute, (route) => false);
//
//
//       emit(SuccessCancelTripState());
//     });
//   }

  DriverTripsModel endTripModel = DriverTripsModel();

  String tripDistance='';

  String tripTime='';
  DateTime?  arrivalTime;
  // void endTrip(BuildContext context, String id) async {
  //   arrivalTime= DateTime.now();
  //
  //
  //   tripTime = arrivalTime!.difference(startTime!).inMinutes.toString();
  //   double distance =calculateDistance(strartlocation, destinaion,);
  //
  //   tripDistance=distance. toStringAsFixed(2).toString();
  //   emit(LoadingEndTripState());
  //   AppWidget.createProgressDialog(context, "wait".tr());
  //
  //   final response = await api.endTrip(
  //       time: tripTime,
  //       distance: distance.toString(),
  //       tripId: id);
  //
  //
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar("error".tr());
  //     emit(FailureEndTripState());
  //   }, (r) {
  //     endTripModel = r;
  //     successGetBar(r.message);
  //
  //     Navigator.pop(context);
  //     emit(SuccessEndTripState());
  //   });
  // }

  //0 for waitingDriver , 1 for driverAcceptTheTrip , 2  for driverStart the trip ,
  //3 for completed
int tripStages =0;

  getDriverAcceptTripStage(){
    tripStages =1;
    emit(ChangeTripStageUIState());
  }
  getDriverStartTripStage(){
    tripStages =2;
    emit(ChangeTripStageUIState());
  } getWaitingDriverStage(){
    tripStages =0;
    emit(ChangeTripStageUIState());
  }getCompletedStage(){
    tripStages =3;
    emit(ChangeTripStageUIState());
  }

//// rate trip
  RateModel rateModel = RateModel();
  void rateTrip(BuildContext context,String tripId,String rate,String to,String description) async {
    emit(LoadingRateTripState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.rateUser(to: to, rate: rate, description: description, tripId:tripId
    );

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureRateTripState());
    }, (r) {
      rateModel = r;
      successGetBar(r.message);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeRoute, (route) => false);
      commentController.clear();
      emit(SuccessRateTripState());
    });
  }
}
