import 'dart:async';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../../core/remote/service.dart';
import '../../../../../../core/utils/custom_marker.dart';

part 'home_driver_state.dart';

class HomeDriverCubit extends Cubit<HomeDriverState> {
  bool inService = true;
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

        if(currentLocation==null||strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){
        strartlocation=  LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        );
getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");
        updateLocation();

        emit(UpdateCurrentLocationState());}
        // setState(() {
        // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
        //  });
      },
    );

    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        if(currentLocation==null||strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){

          strartlocation=  LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          );
        getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");


        updateLocation();
        emit(UpdateCameraPosition());}
      },
    );
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

  getLocation(LatLng argument, String title) async {
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
                .formattedAddress
                .replaceAll("Unnamed Road,", ""),
          ).toBitmapDescriptor();
        }

        getDirection(
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            destinaion);
        emit(UpdateDesitnationLocationState());
        // bitmapDescriptor  = BitmapDescriptor.fromWidget;
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);
      },
    );
  }

  getDirection(LatLng startPosition, LatLng endPosition) async {
    String origin = "", dest = "";
    origin = startPosition.latitude.toString() +
        "," +
        startPosition.longitude.toString();
    dest = endPosition.latitude.toString() +
        "," +
        endPosition.longitude.toString();
    final response = await api.getDirection(origin, dest, "rail");
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
}
