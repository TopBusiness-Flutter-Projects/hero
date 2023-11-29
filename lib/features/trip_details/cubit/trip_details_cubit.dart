import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/models/login_model.dart';
import 'package:hero/core/remote/service.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:meta/meta.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../core/models/rate_trip_model.dart';
import '../../../core/utils/custom_marker.dart';

part 'trip_details_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  TripDetailsCubit(this.api) : super(TripDetailsInitial());
  ServiceApi api ;
  double rate = 0;
  TextEditingController commentController = TextEditingController();


  RateTripModel? rateTripModel;
  giveRate({required int tripId , String? description , required BuildContext context })async{
    emit(LoadingRatingState());
    final response = await api.giveRate(tripId: tripId, rate: rate,description:description );
    response.fold((l) {
      emit(RatingFailedState());
      Navigator.pop(context);
      errorGetBar("something wrong");
    }, (r) {
      if(r.code==200 || r.code ==201){

        Navigator.pop(context);
        rateTripModel = r ;
        emit(RatingSuccessState());
        successGetBar(r.message);
      }
      else if(r.code==500){
        Navigator.pop(context);
        rateTripModel = r ;
        emit(RatingSuccessState());
        successGetBar(r.message);
      }
      else{
        Navigator.pop(context);
        errorGetBar(r.message??"something wrong");
      }
    });
  }
  Set<Marker> markers = {};

  setMarkers(Marker source , Marker? destination){
    markers.clear();
    markers.add(source);
    if(destination!=null){
      markers.add(destination);
    }

    emit(AddDetailsMarkersState());
  }

  BitmapDescriptor? bitmapDescriptorto;
  BitmapDescriptor? bitmapDescriptorfrom;

  setMarkerIcon(String to , LatLng currentLocation, LatLng destination) async {

    bitmapDescriptorto = await CustomeMarker(
      title: 'to'.tr(),
      location:to,
    ).toBitmapDescriptor().then((value) {
      bitmapDescriptorto=value;
      setMarkers(
        Marker(
          markerId: const MarkerId("currentLocation"),
          icon:bitmapDescriptorfrom!,

          position: LatLng(currentLocation?.latitude??0,
              currentLocation?.longitude??0),
        ),
        Marker(
          markerId: MarkerId("destination"),

          icon:value,
          position:destination,
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

}
