import 'dart:async';

import 'dart:math';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/models/end_quick_trip_model.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../../core/models/driver_data_model.dart';
import '../../../../../../core/models/status_model.dart';
import '../../../../../../core/remote/service.dart';
import '../../../../../../core/utils/appwidget.dart';
import '../../../../../../core/utils/custom_marker.dart';
import '../../../../../../core/utils/dialogs.dart';
import '../../../core/models/start_new_trip_model.dart';
import '../../../core/models/update_driver_location_model.dart';
import '../../../core/utils/show_bottom_sheet.dart';
import '../../driver_trip/cubit/driver_trip_cubit.dart';
import '../screen/widgets/enter_client_info_sheet.dart';

part 'home_driver_state.dart';

class HomeDriverCubit extends Cubit<HomeDriverState> {
  bool inService = false;
  LatLng destinaion = LatLng(0, 0);
  LatLng strartlocation = LatLng(0, 0);
  loc.LocationData? currentLocation;
  Uint8List? markerIcon;
  final ServiceApi api;
  List<mp.LatLng> point = [];
  GoogleMapController? mapController;
  BitmapDescriptor? bitmapDescriptorto;
  BitmapDescriptor? bitmapDescriptorfrom;
  String fields = "id,place_id,name,geometry,formatted_address";
  List<LatLng> latLngList = [];

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  TabController? tabsController;

  TextEditingController location_control = TextEditingController();

  HomeDriverCubit(this.api) : super(HomeDriverInitial()) {
    latLngList = [];
    getmarker();
    checkAndRequestLocationPermission();
    getDriverData();
  }
  void switchInService(bool state,BuildContext context) {
changeDriverStatus(context);

    inService = state;
    emit(HomeDriverInService());
  }
  ////////

  void setInitial(){
    destinaion = LatLng(0, 0);
    location_control = TextEditingController();
   origin = "";
    dest = "";
    emit(SetInitialState());
  }

  DriverDataModel driverDataModel=  DriverDataModel ();

  getDriverData() async {
    emit(LoadingGEtDriverDataState());
    final response = await api.getDriverData();
    response.fold((l) {
      emit(FailureGEtDriverDataState());
    }, (r) {
      driverDataModel = r;
      if( r.data!.driverStatus != null)
      inService = r.data!.driverStatus ==1 ;
      emit(SuccessGEtDriverDataState());
    });
  }
  UpdateDriverLocationModel updateDriverLocationModel = UpdateDriverLocationModel();
 updateDriverLocation() async {
    emit(LoadingUpdateDriverLocationState());

    if(currentLocation != null){
      final response = await api.updateDriverLocation(long: currentLocation!.longitude.toString(), lat: currentLocation!.latitude.toString());
      response.fold((l) {
        emit(FailureUpdateDriverLocationState());
      }, (r) {
        updateDriverLocationModel =r;
        emit(SuccessUpdateDriverLocationState());
      });
    }


  }

// Change driver status
  CheckStatusModel checkStatusModel = CheckStatusModel();

  void changeDriverStatus(BuildContext context) async {
    emit(LoadingChangeDriverStatusState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.changeDriverStatus();

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureChangeDriverStatusState());
    }, (r) {
      checkStatusModel = r;
      successGetBar(r.message);
      getDriverData();
      Navigator.pop(context);
      emit(SuccessChangeDriverStatusState());

    });
  }
  // start quick trip

  DateTime? startTime ;
  String formattedTime = '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';


  StartQuickTripModel startQuickTripModel = StartQuickTripModel();

  void startQuickTrip(String name,phone,BuildContext context) async {
    emit(LoadingStartQuickTripState());
    AppWidget.createProgressDialog(context, "wait".tr());
print(destinaion.latitude);
print(destinaion.longitude);
print(strartlocation.latitude);
print(strartlocation.longitude);
    final response = await api.startQuickTrip(
        fromAddress: fromAddress,
        fromLong: strartlocation.longitude.toString(),
        fromLat: strartlocation.latitude.toString(),
        toAddress: toAddress,
        toLong: destinaion.longitude.toString(),
        toLat: destinaion.latitude.toString(),
        phone: phone,
        name: name);

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureStartQuickTripState());
    }, (r) {
      startQuickTripModel = r;
      startTime = DateTime.now();
      Navigator.pop(context);
      successGetBar(r.message);
      getEndStage();

      emit(SuccessStartQuickTripState());

    });
  }
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the earth in kilometers
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c; // Distance in kilometers
    return distance;
  }

// Helper function to convert degrees to radians
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }



  EndQuickTripModel endQuickTripModel = EndQuickTripModel();

  String tripDistance='';

  String tripTime='';
  DateTime?  arrivalTime;
  void endQuickTrip(BuildContext context) async {
    arrivalTime= DateTime.now();



  //  print ('lllllllllllllllll ${startQuickTripModel.data!.phone!}');
    double distance =calculateDistance(strartlocation.latitude, strartlocation.longitude, destinaion.latitude, destinaion.longitude);

   tripDistance=distance. toStringAsFixed(2).toString();
   emit(LoadingEndQuickTripState());
    AppWidget.createProgressDialog(context, "wait".tr());
print(destinaion.latitude);
print(destinaion.longitude);
print(strartlocation.latitude);
print(strartlocation.longitude);
    final response = await api.endQuickTrip(

       phone: startQuickTripModel.data!.phone!,

      distance: distance.toString(),
      time: tripTime,
        );

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureEndQuickTripState());
    }, (r) {
      endQuickTripModel = r;
      startTime =r.data!.startTime!;
      tripTime = arrivalTime!.difference(startTime!).inMinutes.toString();
      Navigator.pop(context);
      successGetBar(r.message);

      getSureStage();
      emit(SuccessEndQuickTripState());

    });
  }
/// set destination

  setDestination(
      String lon,String lat
      ){
    destinaion= LatLng(double.parse(lat), double.parse(lon));
    emit(ChangeTripStageUIState());
  }
  setStartLocation(
      String lon,String lat
      ){
    strartlocation= LatLng(double.parse(lat), double.parse(lon));
    emit(ChangeTripStageUIState());
  }

//********************************************************************************//
  getmarker() async {
    markerIcon = await getBytesFromAsset(ImageAssets.marker, 100);
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //******************************************************************************//

  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    // we can remove this future method because we listen on data in the onLocationChanged.listen
    location.getLocation().then(
      (location) {
        currentLocation = location;

        if(strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){
        strartlocation=  LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        );
       //get the address and draw route
        getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
         // move the camera to the current location
        updateLocation();

        emit(UpdateCurrentLocationState());

        }
      },
    );
    location.onLocationChanged.listen((newLoc) {
    //  currentLocation = newLoc;

      double latDiff = (newLoc.latitude! - strartlocation!.latitude!);
      double lngDiff = (newLoc.longitude! - strartlocation!.longitude!);

      if( latDiff > 0.01 || lngDiff > 0.01){
        strartlocation =  LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        );

        getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
        updateLocation();
        emit(LocationChangedState());
        emit(UpdateCameraPosition());
      }
     });
    // location.onLocationChanged.listen(
    //   (newLoc) {
    //     currentLocation = newLoc;
    //
    //     if(currentLocation==null||strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){
    //
    //       strartlocation=  LatLng(
    //         currentLocation!.latitude!,
    //         currentLocation!.longitude!,
    //       );
    //     getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
    //
    //  // move the camera to the current location
    //     updateLocation();
    //     emit(UpdateCameraPosition());}
    //   },
    // );
  }

  void getCurrentLocationTrip(BuildContext context,LatLng destination) async {
    loc.Location location = loc.Location();
    // we can remove this future method because we listen on data in the onLocationChanged.listen
    location.getLocation().then(
      (location) {
        currentLocation = location;
        if(strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){
        strartlocation=  LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        );
       //get the address and draw route
      //  getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
      //   // move the camera to the current location
      //  updateLocation();

        emit(UpdateCurrentLocationState());

        }
      },
    );
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      double latDiff = (currentLocation!.latitude! - strartlocation!.latitude!);
      double lngDiff = (currentLocation!.longitude! - strartlocation!.longitude!);

      if( latDiff > 0.01 || lngDiff > 0.01){
        strartlocation =  LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        );


        context.read<DriverTripCubit>().getDirection(//widget.trip
            LatLng( currentLocation != null ? currentLocation!.latitude! : 0,
             currentLocation != null ? currentLocation!.longitude! : 0,),
            destination
          //  LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065"))
        );
       // getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
       // updateLocation();
        emit(UpdateCameraPosition());
      }
    });
    // location.onLocationChanged.listen(
    //   (newLoc) {
    //     currentLocation = newLoc;
    //
    //     if(currentLocation==null||strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){
    //
    //       strartlocation=  LatLng(
    //         currentLocation!.latitude!,
    //         currentLocation!.longitude!,
    //       );
    //     getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
    //
    //  // move the camera to the current location
    //     updateLocation();
    //     emit(UpdateCameraPosition());}
    //   },
    // );
  }

  search(String search) async {
    final response = await api.searchOnMap("textquery", search, fields);
    response.fold(
      (l) => emit(ErrorLocationSearch()),
      (r) async {

        destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat,
            r.candidates.elementAt(0).geometry.location.lng);

        bitmapDescriptorto = await CustomeMarker(
          title: 'to'.tr(),
          location: location_control.text,
        ).toBitmapDescriptor();

        getDirection(
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            destinaion);
        emit(UpdateDesitnationLocationState());
        //   });
      },
    );
  }
  String fromAddress ='';
  String toAddress ='';
  String cancelTripToAddress ='';

 cancelWithoutDestinationTrip(BuildContext context,String id)async{
   final response = await api.getGeoData(
       currentLocation!.latitude.toString() + "," + currentLocation!.longitude.toString());
   response.fold(
         (l) => emit(ErrorLocationSearch()),
         (r) async {
           cancelTripToAddress =r.results
               .elementAt(0)
               .formattedAddress
               .replaceAll("Unnamed Road,", "");
           context.read<DriverTripCubit>().cancelTrip(context: context, id: id,
           toAddress: cancelTripToAddress,
           toLong: currentLocation!.longitude.toString(),
             toLat:  currentLocation!.latitude.toString()
           );

       emit(UpdateDesitnationLocationState());
        },
   );
 }


// handle the on tab on map ( set the destination marker and draw the route , get the address)
  getLocation(LatLng argument, String title) async {
     //get the address
    final response = await api.getGeoData(
        argument.latitude.toString() + "," + argument.longitude.toString());

    response.fold(
      (l) => emit(ErrorLocationSearch()),
      (r) async {
        if (title == "to") {
          destinaion = argument;
          location_control.text = r.results
              .elementAt(0)
              .formattedAddress
              .replaceAll("Unnamed Road,", "");
toAddress =r.results
    .elementAt(0)
    .formattedAddress
    .replaceAll("Unnamed Road,", "");
          bitmapDescriptorto = await CustomeMarker(
            title: title.tr(),
            location: r.results
                .elementAt(0)
                .formattedAddress
                .replaceAll("Unnamed Road,", ""),
          ).toBitmapDescriptor();

              }
         else{
          bitmapDescriptorfrom = await CustomeMarker(
            title: title.tr(),
            location: r.results
             .elementAt(0)
            // .addressComponents[0].shortName
                .formattedAddress
                .replaceAll("Unnamed Road,", ""),
          ).toBitmapDescriptor();
          fromAddress =r.results
              .elementAt(0)
              .formattedAddress
              .replaceAll("Unnamed Road,", "");
        }
       // draw the route
        getDirection(
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            destinaion);

        emit(UpdateDesitnationLocationState());
        // bitmapDescriptor  = BitmapDescriptor.fromWidget;
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);
      },
    );
  }

  String origin = "", dest = "";
// draw the route ant it called twice search & get location
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

// move the camera to the current location it called twice in the get current location
  Future<void> updateLocation() async {
    if (mapController != null && currentLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          ),
        ),
      );
    }
  }


//***********************************************************************//

  Future<void> checkAndRequestLocationPermission() async {
    // Check the current status of the location permission
    PermissionStatus permissionStatus = await Permission.location.status;

    if (permissionStatus.isDenied) {
      // If the permission is denied, request it from the user
      PermissionStatus newPermissionStatus =
      await Permission.location.request();

      if (newPermissionStatus.isGranted) {
        await enableLocationServices();
        // Permission granted, continue with location-related tasks
        // Call the function to handle the location-related tasks here
        // ...
      } else if (newPermissionStatus.isDenied) {
        // Permission denied again, handle accordingly (show a message, disable functionality, etc.)
        // ...
      }
    } else if (permissionStatus.isGranted) {
      await enableLocationServices();
      // Permission already granted, continue with location-related tasks
      // Call the function to handle the location-related tasks here
      // ...
    }
  }

  Future<void> enableLocationServices() async {
    loc.Location location = loc.Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location services are still not enabled, handle accordingly (show a message, disable functionality, etc.)
        // ...
        return;
      }
    }

    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isGranted) {
      getCurrentLocation();
      // Location permission is granted, continue with location-related tasks
      // ...
    } else {
      // Location permission is not granted, handle accordingly (show a message, disable functionality, etc.)
      // ...
    }
  }


  //0 for end , 1 for sure

  int tripStages =0;

  getSureStage(){
    tripStages =1;
    emit(ChangeTripStageUIState());
  }
  getEndStage(){
    tripStages =0;
    emit(ChangeTripStageUIState());
  }
}
