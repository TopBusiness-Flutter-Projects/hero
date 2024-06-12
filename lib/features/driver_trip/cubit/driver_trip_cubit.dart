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
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/custom_marker.dart';
import '../../../core/utils/dialogs.dart';
import '../../homedriver/cubit/home_driver_cubit.dart';
import '../../orders/cubit/cubit/orders_cubit.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
part 'driver_trip_state.dart';

class DriverTripCubit extends Cubit<DriverTripState> {
  List<LatLng> latLngListTrip = [];
  List<LatLng> latLngListFromToTrip = [];
  List<mp.LatLng> point = [];
  List<mp.LatLng> pointFromTo = [];

  DriverTripCubit(this.api) : super(DriverTripInitial());
  ServiceApi api;

  double rate = 0;
  TextEditingController commentController = TextEditingController();

  RateModel? rateTripModel;
  LatLng destinaion = LatLng(0, 0);
  LatLng strartlocation = LatLng(0, 0);

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
        latLngListTrip.clear();

        if (r.routes.length > 0) {
          point = mp.PolygonUtil.decode(
              r.routes.elementAt(0).overviewPolyline.points);
          latLngListTrip =
              point.map((e) => LatLng(e.latitude, e.longitude)).toList();
        } else {
          latLngListTrip = [];
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
        latLngListFromToTrip.clear();

        if (r.routes.length > 0) {
          point = mp.PolygonUtil.decode(
              r.routes.elementAt(0).overviewPolyline.points);
          latLngListFromToTrip =
              point.map((e) => LatLng(e.latitude, e.longitude)).toList();
        } else {
          latLngListFromToTrip = [];
        }
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);

        emit(UpdateDesitnationLocationState());
      },
    );
  }

  Set<Marker> markers = {};

  setMarkers({required Marker source, Marker? destination}) {
    markers.clear();
 //   markers.add(source);
    if (destination != null) {
      markers.add(destination);
    }

    emit(AddDetailsMarkersState());
  }

  BitmapDescriptor? bitmapDescriptorto;
  BitmapDescriptor? bitmapDescriptorfrom;

  setMarkerIcon(String? to, LatLng currentLocation, LatLng? destination,
      BuildContext context, String from) async {
    bitmapDescriptorfrom = await CustomeMarker(
      title: 'from'.tr(),
      location: from!,
    ).toBitmapDescriptor().then((value) {
      bitmapDescriptorfrom = value;
      //  strartlocation =currentLocation;
      //  destinaion = destination!;
      emit(RatingSuccessState());
    });

    if (to != null)
      bitmapDescriptorto = await CustomeMarker(
        title: 'to'.tr(),
        location: to,
      ).toBitmapDescriptor().then((value) {
        bitmapDescriptorto = value;
        strartlocation = currentLocation;
        destinaion = destination!;
        emit(RatingSuccessState());

        setMarkers(
          source: Marker(
            markerId: const MarkerId("currentLocation"),
            icon: bitmapDescriptorfrom!,
            position: LatLng(currentLocation?.latitude ?? 0,
                currentLocation?.longitude ?? 0),
          ),
          destination: Marker(
            markerId: MarkerId("destination"),
            icon: value,
            position: destination,
          ),
        );
      });
    else {
      bitmapDescriptorfrom = await Image.asset(ImageAssets.marker2)
          .toBitmapDescriptor()
          .then((value) {
        strartlocation = currentLocation;
        emit(RatingSuccessState());
        setMarkers(
          source: Marker(
            markerId: const MarkerId("currentLocation"),
            icon: context.read<HomeDriverCubit>().markerIcon != null
                ? BitmapDescriptor.fromBytes(
                    context.read<HomeDriverCubit>().markerIcon!)
                : context.read<HomeDriverCubit>().currentLocationIcon,
            position: LatLng(currentLocation?.latitude ?? 0,
                currentLocation?.longitude ?? 0),
          ),
        );
      });
    }

    ;
  }

  setMarkerIcons(String? to, LatLng currentLocation, LatLng? destination,
      BuildContext context) async {
    if (to != null)
      bitmapDescriptorto = await CustomeMarker(
        title: 'to'.tr(),
        location: to,
      ).toBitmapDescriptor().then((value) {
        bitmapDescriptorto = value;
        strartlocation = currentLocation;
        destinaion = destination!;
        emit(RatingSuccessState());

        setMarkers(
          source: Marker(
            markerId: const MarkerId("currentLocation"),
            icon: bitmapDescriptorfrom!,
            position: LatLng(currentLocation?.latitude ?? 0,
                currentLocation?.longitude ?? 0),
          ),
          destination: Marker(
            markerId: MarkerId("destination"),
            icon: value,
            position: destination,
          ),
        );
      });
    else {
      bitmapDescriptorfrom = await Image.asset(ImageAssets.marker2)
          .toBitmapDescriptor()
          .then((value) {
        strartlocation = currentLocation;
        emit(RatingSuccessState());
        setMarkers(
          source: Marker(
            markerId: const MarkerId("currentLocation"),
            icon: context.read<HomeDriverCubit>().markerIcon != null
                ? BitmapDescriptor.fromBytes(
                    context.read<HomeDriverCubit>().markerIcon!)
                : context.read<HomeDriverCubit>().currentLocationIcon,
            position: LatLng(currentLocation?.latitude ?? 0,
                currentLocation?.longitude ?? 0),
          ),
        );
      });
    }

    ;
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

  ///// Driver Trips ///////
// accept trip
  DriverTripsModel acceptTripModel = DriverTripsModel();

  void acceptTrip(BuildContext context, String id) async {
    print('dddddddddddddddddddddd');
    print(context.read<HomeDriverCubit>().currentLocation!.latitude.toString());
    emit(LoadingAcceptTripState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.acceptTrip(
        tripId: id,
        lat: context
                .read<HomeDriverCubit>()
                .currentLocation!
                .latitude
                .toString() ??
            "0",
        long: context
                .read<HomeDriverCubit>()
                .currentLocation!
                .longitude
                .toString() ??
            "0");
    print('ssssssssssss ${response.toString()}');

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureAcceptTripState());
    }, (r) {
      if (r.data != null) {
        acceptTripModel = r;
        successGetBar(r.message);
        Navigator.pop(context);
        getStartStage();
        emit(SuccessAcceptTripState());
      } else {
        Navigator.pop(context);
        errorGetBar(r.message!);
        emit(SuccessAcceptTripState());
        Navigator.pop(context);
        context.read<OrdersCubit>().getAllTrips("new", false);
      }
    });
  }

  // start trip
  DriverTripsModel startTripModel = DriverTripsModel();
  DateTime? startTime;
  void startTrip(BuildContext context, String id) async {
    emit(LoadingStartTripState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.startTrip(
        tripId: id,
        lat: context
                .read<HomeDriverCubit>()
                .currentLocation!
                .latitude
                .toString() ??
            "0",
        long: context
                .read<HomeDriverCubit>()
                .currentLocation!
                .longitude
                .toString() ??
            "0");

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureStartTripState());
    }, (r) {
      startTripModel = r;
      startTime = DateTime.now();

      if (r.data != null) {
        successGetBar(r.message);
        getEndStage();
        Navigator.pop(context);
        emit(SuccessStartTripState());
      } else {
        Navigator.pop(context);
        errorGetBar(r.message!);
      }
    });
  }

  DriverTripsModel cancelTripModel = DriverTripsModel();

  void cancelTrip({
    required BuildContext context,
    required String id,
    String? toAddress,
    String? toLat,
    String? toLong,
  }) async {
    emit(LoadingCancelTripState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.cancelTrip(
        tripId: id, toAddress: toAddress, toLat: toLat, toLong: toLong);

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureCancelTripState());
    }, (r) {
      cancelTripModel = r;
      successGetBar(r.message);

      Navigator.pop(context);

      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homedriverRoute, (route) => false);

      emit(SuccessCancelTripState());
    });
  }

  DriverTripsModel endTripModel = DriverTripsModel();

  String tripDistance = '';

  String tripTime = '';
  DateTime? arrivalTime;
  void endTrip({
    required BuildContext context,
    required String id,
    String? toAddress,
    String? toLat,
    String? toLong,
  }) async {
    arrivalTime = DateTime.now();

    // tripTime = arrivalTime!.difference(startTime!).inMinutes.toString();
    double distance = calculateDistance(
      strartlocation,
      destinaion,
    );
    tripDistance = distance.toStringAsFixed(2).toString();
    emit(LoadingEndTripState());
    AppWidget.createProgressDialog(context, "wait".tr());
    final response = await api.endTrip(
        tripId: id, toAddress: toAddress, toLat: toLat, toLong: toLong);
    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureEndTripState());
    }, (r) {
      endTripModel = r;
      successGetBar(r.message);

      Navigator.pop(context);
      emit(SuccessEndTripState());
    });
  }
  // void endTrip(BuildContext context, String id) async {
  //   arrivalTime= DateTime.now();

  //  // tripTime = arrivalTime!.difference(startTime!).inMinutes.toString();
  //   double distance =calculateDistance(strartlocation, destinaion,);
  //   tripDistance=distance. toStringAsFixed(2).toString();
  //   emit(LoadingEndTripState());
  //   AppWidget.createProgressDialog(context, "wait".tr());
  //   final response = await api.endTrip(
  //      // time: tripTime,
  //       distance: distance.toString(),
  //       tripId: id);
  //   response.fold((l) {
  //     Navigator.pop(context);
  //     errorGetBar("error".tr());
  //     emit(FailureEndTripState());
  //   }, (r) {
  //     endTripModel = r;
  //     successGetBar(r.message);

  //     Navigator.pop(context);
  //     emit(SuccessEndTripState());
  //   });
  // }
  //0 for accept , 1 for start , 2  for end
  int tripStages = 0;

  getStartStage() {
    tripStages = 1;
    emit(ChangeTripStageUIState());
  }

  getEndStage() {
    tripStages = 2;
    emit(ChangeTripStageUIState());
  }

  getAcceptStage() {
    tripStages = 0;
    emit(ChangeTripStageUIState());
  }

//// rate trip
  RateModel rateModel = RateModel();
  void rateUser(BuildContext context, String tripId, String rate, String to,
      String description) async {
    emit(LoadingRateTripState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.rateUser(
        to: to, rate: rate, description: description, tripId: tripId);

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureRateTripState());
    }, (r) {
      rateModel = r;
      successGetBar(r.message);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homedriverRoute, (route) => false);
      commentController.clear();
      emit(SuccessRateTripState());
    });
  }
}
