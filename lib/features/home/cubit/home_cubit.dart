import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/geocoding.dart'as geocoding;
import 'package:location/location.dart'as loc;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int? flag;

  HomeCubit() : super(HomeInitial());
  String? payment = "cash";
  late TabController tabsController ;
 // GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
   LatLng sourceLocation = LatLng(31.2693, 30.7873);
    LatLng destination = LatLng(30.4301, 31.0364);
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
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g", // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      emit(UpdatePlyLinesState());
     // setState(() {});
    }
  }
  changeToRideNowState(){
    bottomContainerInitialState = false;
    bottomContainerLoadingState = true;
    emit(ChangeToRideNowState());
  }

  loc.LocationData? currentLocation;

  void getCurrentLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
        sourceLocation = LatLng(location.latitude!, location.longitude!);
        emit(UpdateCurrentLocationState());
       // setState(() {
          // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
      //  });
      },
    );
    GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        //sourceLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
       // setState(() {});
            emit(UpdateCameraPosition());
      },
    );
  }

  searchOnMap(BuildContext context) async {
    var place = await PlacesAutocomplete.show(
        context: context,
        apiKey: "AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g",
        mode: Mode.overlay,
        types: [],
        strictbounds: false,
        components: [
          geocoding.Component(geocoding.Component.country, 'eg')],
        //google_map_webservice package
        onError: (err){
          print(err);
        }
    );

    if(place!=null){
     // setState(() {
        location = place.description.toString();
     // });
        emit(SearchState());

      //form google_maps_webservice package
      final plist = GoogleMapsPlaces(apiKey:"AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g",
          apiHeaders: await GoogleApiHeaders().getHeaders(),
    //from google_api_headers package
    );

    String placeid = place.placeId ?? "0";
    final detail = await plist.getDetailsByPlaceId(placeid);
    final geometry = detail.result.geometry!;
    final lat = geometry.location.lat;
    final lang = geometry.location.lng;
    var newlatlang = LatLng(lat, lang);

    //move map camera to selected place with animation

    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 14)));

    destination = newlatlang;
    getPolyPoints();
  }
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
