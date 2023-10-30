import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/remote/service.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart'as geocoding;
import 'package:location/location.dart'as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/custom_marker.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int? flag;
  Set<Marker> markers = {};
  HomeCubit(this.api) : super(HomeInitial()){
    markers =  {
      Marker(
        markerId: const MarkerId("currentLocation"),
        icon: currentLocationIcon,

        position: LatLng(currentLocation?.latitude??0,
            currentLocation?.longitude??0),
      ),
      // Marker(
      //   markerId: const MarkerId("source"),
      //   infoWindow: InfoWindow(
      //     title: "from",
      //   ),
      //  // icon: customMarkerIcon,
      //   icon: cubit.sourceIcon,
      //   position: cubit.sourceLocation,
      // ),
      Marker(
        markerId: MarkerId("destination"),
        infoWindow: InfoWindow(
          title: "to",
        ),
        icon: destinationIcon,
        position: destinationH,
      ),
      //  markers.first
    };
    latLngList = [];
    getmarker();
    checkAndRequestLocationPermission();
  }
  ServiceApi api;
  String? payment = "cash";
  late TabController tabsController ;
 // GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
   LatLng sourceLocation = LatLng(31.2693, 30.7873);
  //  LatLng destination = LatLng(30.4301, 31.0364);
  TextEditingController locationControl = TextEditingController();
    bool bottomContainerInitialState = true;
    bool bottomContainerLoadingState = false;
    bool bottomContainerFailureState = false;
    bool bottomContainerSuccessState = false;
    //ride now variables
  bool bottomContainerInitialState1 = true;
  bool bottomContainerLoadingState1 = false;
  bool bottomContainerFailureState1 = false;
  bool bottomContainerSuccessState1 = false;
   DateTime? datePicked;
   TimeOfDay? timePicked;
 // DateTime date = new DateTime.now();
  DateTime? date ;
  var dateFormatted;
  var timeFormatted;
  final oo.DateFormat dateFormatter = oo.DateFormat('d MMM EEE');
  TimeOfDay time = new TimeOfDay.now();
  final Completer<GoogleMapController> controller = Completer();
  GoogleMapController? mapController;
  String location = "Search Location";
void setflag(int flag){
  this.flag=flag;
  emit(HomeInitial());
}
  onMapCreated(GoogleMapController mapController){
    controller.complete(mapController);
   // _customInfoWindowController.googleMapController = mapController;
    this.mapController = mapController;
    // setState(() {
    //
    // });
    emit(OnMapCreatedState());
  }


  List<LatLng> latLngList = [];
  List<mp.LatLng> point=[];

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
          (l) => emit(ErrorLocationSearchState()),
          (r) {
        latLngList.clear();

        if(r.routes.length>0){
          point = mp.PolygonUtil.decode(
              r.routes.elementAt(0).overviewPolyline.points);
          latLngList =
              point.map((e) => LatLng(e.latitude, e.longitude)).toList();}
        else{
          latLngList=[];
        }
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);

        emit(UpdateDesitnationLocation());
      },
    );
  }

  TextEditingController location_control = TextEditingController();


// handle the on tab user event on map
  getLocation(LatLng argument) async {
    locationControl.text = "";
    final response = await api.getGeoData(
        argument.latitude.toString() + "," + argument.longitude.toString());
    response.fold(
          (l) => emit(ErrorLocationSearchStat()),
          (r) {
        destinationH = argument;
        location_control.text = r.results
            .elementAt(0)
            .formattedAddress
            .replaceAll("Unnamed Road,", "");
      setMarkers(
          Marker(
            markerId: const MarkerId("currentLocation"),
            icon: currentLocationIcon,

            position: LatLng(currentLocation?.latitude??0,
               currentLocation?.longitude??0),
          ),
          Marker(
            markerId: MarkerId("destination"),
            infoWindow: InfoWindow(
              title: "to",
            ),
            icon: destinationIcon,
            position:destinationH,
          ), );
        // destinaion = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);
        getDirection(
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            destinationH);

        emit(UpdateDesitnationLocationStat());
      },
    );
  }

  setMarkers(Marker source , Marker? destination){
    markers.clear();
    markers.add(source);
    if(destination!=null){
      markers.add(destination);
    }

    emit(AddMarkersState());
  }

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g", // Your Google Map Key
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destinationH.latitude, destinationH.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //           (PointLatLng point) => polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     emit(UpdatePlyLinesState());
  //    // setState(() {});
  //   }
  // }


  changeToRideNowState(){
    bottomContainerInitialState = false;
    bottomContainerLoadingState = true;
   // latLngList = [];
    // Marker marker = markers.firstWhere((marker) => marker.markerId.value == "destination",);
    // markers.remove(marker);
    emit(ChangeToRideNowState());

  }

  //step 1 get the location permission
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

  Uint8List? markerIcon;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  getmarker() async {
    markerIcon = await getBytesFromAsset(ImageAssets.marker, 100);
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


  loc.LocationData? currentLocation;

  // void getCurrentLocation() async {
  //   loc.Location location = loc.Location();
  //   location.getLocation().then(
  //         (location) {
  //       currentLocation = location;
  //       sourceLocation = LatLng(location.latitude!, location.longitude!);
  //       emit(UpdateCurrentLocationState());
  //      // setState(() {
  //         // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
  //     //  });
  //     },
  //   );
  //   GoogleMapController googleMapController = await controller.future;
  //   location.onLocationChanged.listen(
  //         (newLoc) {
  //       currentLocation = newLoc;
  //       //sourceLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
  //       googleMapController.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             zoom: 13.5,
  //             target: LatLng(
  //               newLoc.latitude!,
  //               newLoc.longitude!,
  //             ),
  //           ),
  //         ),
  //       );
  //      // setState(() {});
  //           emit(UpdateCameraPosition());
  //     },
  //   );
  // }

  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
        updateLocation();
        emit(UpdateCurrentLocationState());
        // setState(() {
        // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
        //  });
      },
    );

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
        updateLocation();
        emit(UpdateCameraPosition());
      },
    );
  }
  Uint8List? icon;
  Future<void> updateLocation() async {
    if (mapController != null && currentLocation != null) {
      // icon = await MarkersWithLabel.getBytesFromCanvasDynamic(
      //     iconPath:ImageAssets.marker,
      //     plateReg:location_control.text,
      //     fontSize: 10.0,
      //     iconSize: Size(10, 10)
      // );
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

  // searchOnMap(BuildContext context) async {
  //   var place = await PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: "AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g",
  //       mode: Mode.overlay,
  //       types: [],
  //       strictbounds: false,
  //       components: [
  //         geocoding.Component(geocoding.Component.country, 'eg')],
  //       //google_map_webservice package
  //       onError: (err){
  //         print(err);
  //       }
  //   );
  //
  //   if(place!=null){
  //    // setState(() {
  //       location = place.description.toString();
  //    // });
  //       emit(SearchState());
  //
  //     //form google_maps_webservice package
  //     final plist = GoogleMapsPlaces(apiKey:"AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g",
  //         apiHeaders: await GoogleApiHeaders().getHeaders(),
  //   //from google_api_headers package
  //   );
  //
  //   String placeid = place.placeId ?? "0";
  //   final detail = await plist.getDetailsByPlaceId(placeid);
  //   final geometry = detail.result.geometry!;
  //   final lat = geometry.location.lat;
  //   final lang = geometry.location.lng;
  //   var newlatlang = LatLng(lat, lang);
  //
  //   //move map camera to selected place with animation
  //
  //   mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 14)));
  //
  //   destination = newlatlang;
  //   getPolyPoints();
  // }
  // }
  String fields = "id,place_id,name,geometry,formatted_address";
  LatLng destinationH = LatLng(0, 0);


  // searchOnMapH(String searchKey) async {
  //   emit(LoadingSearchState());
  //  final response = await api.searchOnMap("textquery", searchKey, fields);
  //  response.fold((l) => emit(FailureSearchState()),
  //          (r) {
  //            destinationH = LatLng( r.candidates.elementAt(0).geometry.location.lat,r.candidates.elementAt(0).geometry.location.lng );
  //       emit(SuccessSearchState());
  //  });
  // }

  search(String search) async {
    emit(LoadingSearchState());
    final response = await api.searchOnMap("textquery",search,fields);
    response.fold(
          (l) => emit(FailureSearchState()),
          (r) {
            destinationH = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);
            setMarkers(
              Marker(
                markerId: const MarkerId("currentLocation"),
                icon: currentLocationIcon,

                position: LatLng(currentLocation?.latitude??0,
                    currentLocation?.longitude??0),
              ),
              Marker(
                markerId: MarkerId("destination"),
                infoWindow: InfoWindow(
                  title: "to",
                ),
                icon: destinationIcon,
                position:destinationH,
              ), );
            getDirection(
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!), destinationH);
        emit(SuccessSearchState());
      },
    );
  }


changeRadioButton(value){
  //setState(() {
    payment = value.toString();
    emit(ChangeRadiState());
 // });
}

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/pin_source1.png",
    ).then(
          (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/pin_destination1.png")
        .then(
          (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/badge1.png")
        .then(
          (icon) {
        currentLocationIcon = icon;
      },
    );
  }


  Future<Null> _selectDate(BuildContext context) async {
     datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(2023),
      lastDate: new DateTime(2030),

    );


    if(datePicked != null && datePicked != date) {
      print('Date selected: ${date.toString()}');
     // setState((){
        date = datePicked;

        dateFormatted = dateFormatter.format(datePicked!);
        emit(DateUpdateState());
     // });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
     timePicked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if(timePicked != null && timePicked != time) {
      print('Time selected: ${time.toString()}');
      //setState((){
        time = timePicked!;
        timeFormatted = time.format(context);
        emit(TimeUpdateState());
    //  });
    }
 // else{
 //   await selectDateAndTime(context);
 //    }
  }
 confirmPopUp(BuildContext context){
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(ImageAssets.dateConfirm),
                  Text("sure_about_date").tr(),
                  Text(" $dateFormatted $timeFormatted",textDirection: TextDirection.ltr,),
                  //Text("time: $timeFormatted"),
                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  context.read<HomeCubit>().tabsController.animateTo(0);
                  }, child: Text("confirm".tr()))

                ],
              ),
              InkWell(
                onTap: () async {

                 await selectDateAndTime(context);
                 Navigator.pop(context);
                },
                  child: SvgPicture.asset("assets/icons/close.svg"))
            ],
          ),
        ),
      );
    },);
 }

  Future<Null> selectDateAndTime(BuildContext context) async {
    await _selectDate(context);
    if(datePicked!=null){
      await _selectTime(context);
      if(timePicked!=null){
        confirmPopUp(context);
      }

    }


  }
}
