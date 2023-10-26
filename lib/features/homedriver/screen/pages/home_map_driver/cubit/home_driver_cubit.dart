import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

import '../../../../../../core/remote/service.dart';

part 'home_driver_state.dart';

class HomeDriverCubit extends Cubit<HomeDriverState> {
  bool inService = true;
  LatLng destinaion = LatLng(0, 0);
  loc.LocationData? currentLocation;
  Uint8List? markerIcon;
  final ServiceApi api;
  String fields = "id,place_id,name,geometry,formatted_address";

  final Completer<GoogleMapController> controller = Completer();
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  TabController? tabsController ;
  TextEditingController location_control = TextEditingController();

  HomeDriverCubit(this.api) : super(HomeDriverInitial()){

    getmarker();
    checkAndRequestLocationPermission();
  }

  void switchInservice(bool state) {
    inService = state;
    emit(HomeDriverInService());
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
  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        emit(UpdateCurrentLocationState());
        // setState(() {
        // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
        //  });
      },
    );

    GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        print("dkkdkdk");
        currentLocation = newLoc;
        //sourceLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
        // googleMapController.animateCamera(
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       zoom: 13.5,
        //       target: LatLng(
        //         newLoc.latitude!,
        //         newLoc.longitude!,
        //       ),
        //     ),
        //   ),
        // );
        // setState(() {});
        emit(UpdateCameraPosition());
      },
    );
  }
  search(String search) async {

    final response = await api.searchOnMap("textquery",search,fields);
    response.fold(
          (l) => emit(ErrorLocationSearch()),
          (r) {
            destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);

        emit(UpdateDesitnationLocationState());
      },
    );
  }

   getLocation(LatLng argument) async {

     final response = await api.getGeoData(
         argument.latitude.toString() + "," +  argument.longitude.toString()
     );
     response.fold(
           (l) => emit(ErrorLocationSearch()),
           (r) {
             destinaion=argument;
             location_control.text=r.results.elementAt(0).formattedAddress.replaceAll("Unnamed Road,", "");
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);

         emit(UpdateDesitnationLocationState());
       },
     );
   }

}
