import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/models/create_trip_model.dart';
import 'package:hero/core/models/delete_user_model.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/core/models/notification_model.dart';
import 'package:hero/core/models/settings_model.dart';
import 'package:hero/core/preferences/preferences.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/features/home/components/default_widget.dart';
import 'package:hero/features/home/components/failure_widget.dart';
import 'package:hero/features/home/components/loading_widget.dart';
import 'package:hero/features/home/components/success_widget.dart';
import 'package:hero/features/user_trip/cubit/user_trip_cubit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/remote/service.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart'as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/check_document_model.dart';
import '../../../core/models/check_trip_status_model.dart';
import '../../../core/models/create_schedual_trip_model.dart';
import '../../../core/models/favourite_model.dart';
import '../../../core/models/signup_response_model.dart';
import '../../../core/utils/custom_marker.dart';
import '../../driver_trip/cubit/driver_trip_cubit.dart';
import '../../homedriver/cubit/home_driver_cubit.dart';
part 'home_state.dart';


enum MyEnum {
  success,
  defaultState,
  load,
  failure,
}

class HomeCubit extends Cubit<HomeState> {
  MyEnum currentEnumStatus = MyEnum.defaultState;
  int? flag;
  Set<Marker> markers = {};
  Set<Marker> tripMarkers = {};
  BitmapDescriptor? bitmapDescriptorto;
  BitmapDescriptor? bitmapDescriptorfrom;
  SignUpModel? signUpModel ;

  HomeCubit(this.api) : super(HomeInitial()){
   getUserData();
   getSettings();
   getTripStatus();
    latLngList = [];
    getmarker();
    checkAndRequestLocationPermission();
   getNotification();
   //getNotification();
   //getHomeData();// it's better to call this method in initstate

  }
  getUserData() async {
    signUpModel = await Preferences.instance.getUserModel();

    emit(GettingUserData());
  }
  ServiceApi api;
  String? payment = "cash";
  late TabController tabsController ;
 // GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
   LatLng sourceLocation = LatLng(31.2693, 30.7873);
  //  LatLng destination = LatLng(30.4301, 31.0364);
 // TextEditingController locationControl = TextEditingController();
 //    bool bottomContainerInitialState = true;
 //    bool bottomContainerLoadingState = false;
 //    bool bottomContainerFailureState = false;
 //    bool bottomContainerSuccessState = false;

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

  BitmapDescriptor defaultLocationIcon = BitmapDescriptor.defaultMarker;

void setflag(int flag){
  this.flag=flag;
  emit(HomeInitial());
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
    final response = await api.getDirection(origin, dest, "bus");
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



  setMarkers(Marker source , Marker? destination){
    markers.clear();
    markers.add(source);
    if(destination!=null){
      markers.add(destination);
    }

    emit(AddMarkersState());
  }
  setTripMarkers(Marker source , Marker? destination){
    tripMarkers.clear();
    tripMarkers.add(source);
    if(destination!=null){
      tripMarkers.add(destination);
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


  // changeToRideNowState(){
  //   bottomContainerInitialState = false;
  //   bottomContainerLoadingState = true;
  //  // latLngList = [];
  //   // Marker marker = markers.firstWhere((marker) => marker.markerId.value == "destination",);
  //   // markers.remove(marker);
  //   emit(ChangeToRideNowState());
  //
  // }

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
      else{
        getCurrentLocation();

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




  loc.LocationData? currentLocation;
  String? address;


  LatLng strartlocation = LatLng(0, 0);

double distance = 0;
double paymentMoney = 0;

// handle the on tab user event on map

setMyMarker(NewTrip trip)async{


    bitmapDescriptorfrom = await CustomeMarker(
      title: "from".tr(),
      location: trip.fromAddress!,
    ).toBitmapDescriptor().then((value) async{
      bitmapDescriptorfrom=value;

if (trip.toAddress != null)

  {
    bitmapDescriptorto = await CustomeMarker(
      title: "to".tr(),
      location: trip.toAddress!,
    ).toBitmapDescriptor().then((value) {
      bitmapDescriptorto=value;

      setTripMarkers(
        Marker(
          markerId: const MarkerId("from"),
          icon:bitmapDescriptorfrom!,
          position: LatLng(double.parse(trip.fromLat!),
              double.parse(trip.fromLong!)),
        ),
        Marker(
          markerId: MarkerId("to"),

          icon:bitmapDescriptorto!,
          position:LatLng(double.parse(trip.toLat!),
              double.parse(trip.toLong!)),
        ),
      );
    });
  }
else{
  setTripMarkers(
    Marker(
      markerId: const MarkerId("from"),
      icon:bitmapDescriptorfrom!,
      position: LatLng(double.parse(trip.fromLat!),
          double.parse(trip.fromLong!)),
    ),null
  );
}


    });



}

  getLocation(LatLng argument, String title) async {
    //location_control.text  = "";
    final response = await api.getGeoData(
        argument.latitude.toString() + "," + argument.longitude.toString());

    response.fold(
          (l) => emit(ErrorLocationSearchStat()),
          (r) async {
        address =  r.results
            .elementAt(0)
            .formattedAddress
            .replaceAll("Unnamed Road,", "");

        if(title=="to"){
          destination = argument;
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
        else{
          bitmapDescriptorfrom = await CustomeMarker(
            title: title.tr(),
            location: r.results
                .elementAt(0)
                .formattedAddress
                .replaceAll("Unnamed Road,", ""),
          ).toBitmapDescriptor().then((value) {
            bitmapDescriptorfrom=value;

            setMarkers(
              Marker(
                markerId: const MarkerId("currentLocation"),
                icon:value,

                position: LatLng(currentLocation?.latitude??0,
                    currentLocation?.longitude??0),
              ),
              Marker(
                markerId: MarkerId("destination"),

                icon:bitmapDescriptorto!=null?bitmapDescriptorto!:currentLocationIcon,
                position:destination,
              ),
            );
          });

        }

        if(destination.longitude!=0&&destination.latitude!=0){
          distance =  calculateDistance(LatLng(currentLocation!.latitude!, currentLocation!.longitude!),destination);
          paymentMoney = distance * settingsModel!.data!.km!;
        }

        getDirection(
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            destination);

        emit(UpdateDesitnationLocationStat());
      },
    );
  }


  void getCurrentLocation() async {

    loc.Location location = loc.Location();
    // we can remove this future method because we listen on data in the onLocationChanged.listen
    location.getLocation().then(
          (location) async {
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

    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;

        if(currentLocation==null||strartlocation!=LatLng(currentLocation!.latitude!,currentLocation!.longitude!)){

          strartlocation=  LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!,
          );
          getLocation(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "from");

          // move the camera to the current location
          updateLocation();
          emit(UpdateCameraPosition());}
      },
    );
  }



  Uint8List? icon;
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


  String fields = "id,place_id,name,geometry,formatted_address";
  LatLng destination = LatLng(0, 0);




  search(String search) async {
    emit(LoadingSearchState());
    final response = await api.searchOnMap("textquery",search,fields);
    response.fold(
          (l) => emit(FailureSearchState()),
          (r) async {
            destination = LatLng(r.candidates.elementAt(0).geometry.location.lat, r.candidates.elementAt(0).geometry.location.lng);
            //todo => calculate the distance and price
            if(destination.longitude!=0&&destination.latitude!=0){
              distance =  calculateDistance(LatLng(currentLocation!.latitude!, currentLocation!.longitude!),destination);
              paymentMoney = distance * settingsModel!.data!.km!;
            }
            bitmapDescriptorto = await CustomeMarker(
              title: 'to'.tr(),
              location: location_control.text,
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



            getDirection(
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!), destination);
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


  //*****************************************************************//

  Future<Null> _selectDate(BuildContext context) async {
     datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(2023),
      lastDate: new DateTime(2030),

    );


    if(datePicked != null && datePicked != date) {

        date = datePicked;
        dateFormatted = dateFormatter.format(datePicked!);
        emit(DateUpdateState());
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
     timePicked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if(timePicked != null) {

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
                  ElevatedButton(
                      onPressed: ()  {
                    Navigator.pop(context);

                     createScheduleTrip(tripType: flag==1?"with":"without", context: context);


                  }, child: Text("confirm".tr()))

                ],
              ),
              InkWell(
                onTap: () async {

              //   await selectDateAndTime(context);
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

  deleteUser(BuildContext context)async{
  loadingDialog();
    final response = await api.delete();
    response.fold((l) {
      emit(FailedDeleteUser());
      Navigator.pop(context);
      errorGetBar("failed to delete user");
      } ,
            (r) {
         if(r.code==200){
           emit(SuccessDeleteUser());
           Preferences.instance.clearShared();
           Navigator.pop(context);
           Navigator.pushReplacementNamed(context, Routes.loginRoute);
         }
         else{
           emit(FailedDeleteUser());
           Navigator.pop(context);
           errorGetBar(r.message??"failed to delete user");
         }
    });
  }


  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  DeleteModel? deleteModel;
  logout(BuildContext context)async{

    emit(LoadingToLogOutState());
    loadingDialog();
    String? token = await _getId();
    Preferences.instance.clearShared();
    Navigator.pop(context);
    emit(SuccessToLogOutState());
    Navigator.pushNamedAndRemoveUntil(context,
        Routes.initialRoute, (route) => false);
    // if(token!=null){
    //   final response = await api.logout(token);
    //   response.fold((l) {
    //     Navigator.pop(context);
    //     emit(FailureToLogOutState());
    //   }, (r) {
    //
    //     deleteModel = r;
    //
    //   });

    // }
    // else{
    //   Navigator.pop(context);
    //   ErrorWidget("token is null");
    // }
  }

  HomeModel? homeModel;
  getHomeData()async{
    //loadingDialog();
    emit(LoadingHomeDataState());
   final response = await api.getHomeData();
   response.fold((l) {
     emit(ErrorGettingHomeDataState());
     //Navigator.pop(context);
   }, (r) {

     homeModel = r ;
    // Navigator.pop(context);
     emit(SuccessGettingHomeData());
   });
  }
  CarouselController carouselController = CarouselController();

  SettingsModel settingsModel=SettingsModel();
bool isLoadingSettings = true;
  getSettings()async{
    emit(LoadingSettings());
    isLoadingSettings = true;
  final response = await  api.getSettings();
  response.fold((l) {
    emit(FailureSettings());
  }, (r) {
     if(r.code==200){
       settingsModel = r;
       isLoadingSettings = false;
       emit(SuccessSettings());
     }

  });
  }

  CheckTripStatusModel checkTripStatusModel=CheckTripStatusModel();

  getTripStatus()async{
    emit(LoadingCheckTripStatusState());

  final response = await  api.checkTripStatus();
  response.fold((l) {
    emit(FailureCheckTripStatusState());
  }, (r) {
           checkTripStatusModel = r;
       emit(SuccessCheckTripStatusState());
  });
  }


  CheckTripStatusModel checkTripStatusModelOfDriver=CheckTripStatusModel();

  getDriverTripStatus(BuildContext context)async{
    emit(LoadingCheckTripStatusState());

  final response = await  api.checkTripStatus();
  response.fold((l) {
    emit(FailureCheckTripStatusState());
  }, (r) {
    checkTripStatusModelOfDriver = r;

    print ('lllllllllllllllllllllll trip in progress');

           if (r.data != null){
             // رحلة فورية

             if (r.data!.tripType == 'quick'){
               if(r.data!.type =='progress'){
                 context.read<HomeDriverCubit>().setDestination(r.data!.toLong!, r.data!.toLat!);
                 context.read<HomeDriverCubit>().setStartLocation(r.data!.fromLong!, r.data!.fromLat!);
                 context.read<HomeDriverCubit>().startQuickTripModel.data=r.data;
                 Navigator.pushNamed(
                     context, Routes.QuickTripScreen,
                     arguments: r.data);
               }
             }
             else{
               // بوجهة
              // if (r.data!.tripType == 'with'){
                 if(r.data!.type =='progress'){
                   context.read<DriverTripCubit>().tripStages =2;
                 //  context.read<DriverTripCubit>().getEndStage();
                   Navigator.pushNamed(context,
                       Routes.DriverTripScreen,
                       arguments:
                      r.data);
                 }else if(r.data!.type =='accept'){
                 //  context.read<DriverTripCubit>().getStartStage;
                   context.read<DriverTripCubit>().tripStages =1;
                   print('gggggggggggggggggggg ${context.read<DriverTripCubit>().tripStages}');
                   Navigator.pushNamed(context,
                       Routes.DriverTripScreen,
                       arguments:
                       r.data);
                 }


             //  }
               // بدون وجهة
               // else{
               //   if(r.data!.type =='progress'){
               //
               //
               //   }else if(r.data!.type =='accept'){
               //
               //   }
               //
               // }






             }

           }
       emit(SuccessCheckTripStatusState());
  });
  }
  CheckTripStatusModel checkTripStatusModelOfUser=CheckTripStatusModel();

  getUserTripStatus(BuildContext context)async{
    emit(LoadingCheckTripStatusState());

  final response = await  api.checkTripStatus();
  response.fold((l) {
    emit(FailureCheckTripStatusState());
  }, (r) {
    checkTripStatusModelOfUser = r;

    print ('lllllllllllllllllllllll trip in progress');

           if (r.data != null){
//if(r.data!.tripType!= "schedule"){

  if(r.data!.type =='progress'){
    context.read<UserTripCubit>().tripStages =2;

    Navigator.pushNamed(context,
        Routes.UserTripScreen,
        arguments:
        r.data);
  }else if(r.data!.type =='accept'){
    //  context.read<DriverTripCubit>().getStartStage;
    context.read<UserTripCubit>().tripStages =1;
    Navigator.pushNamed(context,
        Routes.UserTripScreen,
        arguments:
        r.data);
  }else if(r.data!.type == 'new'){
    context.read<UserTripCubit>().tripStages =0;
    Navigator.pushNamed(context,
        Routes.UserTripScreen,
        arguments:
        r.data);
  }

// }
// else{
//
// }



           }
       emit(SuccessCheckTripStatusState());
  });
  }

  void launchPhoneDialer(String phoneNumber) async {


    String url = 'tel:${settingsModel.data!.phone}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  rateApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String url = '';
    String packageName = packageInfo.packageName;

    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/details?id=${packageName}";
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/us/app/${packageName}';
    }
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  NotificationModel? notificationModel;
  getNotification()async{
    emit(LoadingNotificationState());
    final response = await api.getNotification();
    response.fold((l) {
      emit(FailureNotificationState());
    }, (r) {
      notificationModel = r ;
      // Calculate the time difference
      emit(SuccessNotificationState());
    });

  }

  FavouriteModel? favouriteModel;
  getFavourite()async{
    emit(LoadingFavouriteState());
    final response = await api.getFavourite();
    response.fold((l) {
      emit(FailureFavouriteState());
    }, (r) {
      favouriteModel = r ;
      // Calculate the time difference
      emit(SuccessFavouriteState());
    });

  }

  deleteFavourite({required int addressId , required BuildContext context})async{
    loadingDialog();
     final response = await api.deleteFavourite(addressId);
     response.fold((l) {
       Navigator.pop(context);
       emit(FailureDeletingFavourite());
     }, (r) {
       if(r.code==200){
         Navigator.pop(context);
         getFavourite();
         emit(SuccessDeletingFavourite());
         successGetBar(r.message);
       }
       else if(r.code==404){
         Navigator.pop(context);
         emit(NoAdressFound());
         errorGetBar(r.message!);
       }
       else{
         Navigator.pop(context);
         emit(FailureDeletingFavourite());
         errorGetBar(r.message!);
       }
     });
  }



  addFavourite({required String address,required String lat ,required String  long, required BuildContext context})async{

    emit(LoadingAddToFavourite());
    loadingDialog();

    // Check if the address already exists in the favoriteModel
  if(favouriteModel != null && favouriteModel?.data != null){
    for(FavouriteData data in favouriteModel!.data!){

      if(data.address?.trim() == address.trim()){
        Navigator.pop(context);
        emit(AddressAlreadyExists());
        successGetBar("address_exist".tr());
        return;
      }
    }
  }


    final response = await api.addFavourite(address: address,lat: lat,long:long );
    response.fold((l) {
      Navigator.pop(context);
      emit(FailureAddingFavourite());
    }, (r) {
      if(r.code==200 || r.code ==201){
        Navigator.pop(context);
        getFavourite();
        emit(SuccessAddingFavourite());
        successGetBar(r.message);
      }

      else{
        Navigator.pop(context);
        emit(FailureAddingFavourite());
        errorGetBar(r.message!);
      }
    });
  }

  CreateTripModel? createTripModel;

  createTrip({required String tripType , required BuildContext context})async{
print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    if(address!=null && currentLocation!=null){
       emit(LoadingCreateTripState());
     // loadingDialog();

      final response = await  api.createTrip(
          tripType: tripType, fromAddress: address!, fromLng: currentLocation!.longitude!,
          fromLat: currentLocation!.latitude!,
          toAddress:tripType=="with"?
          location_control.text :null,
          toLat:tripType=="with"?
          destination.latitude:null,
          toLng:tripType=="with"?
          destination.longitude:null);
          response.fold((l) {
           emit(FailureCreateTrip());
         //  Navigator.pop(context);
           errorGetBar("couldn't create trip");
          }, (r) {
      if(r.code==200 || r.code ==201){
        createTripModel = r;

        print(createTripModel);
       // bottomContainerLoadingState = true;
        if (r.data == null)
        {
          errorGetBar(r.message!);
        }else{

          Navigator.pushNamed(context,
              Routes.UserTripScreen,
              arguments:
             r.data);
         // currentEnumStatus = MyEnum.load;
          emit(SuccessCreateTripState());
          successGetBar(r.message!);
        }


      }

      else if(r.code==502|| r.code==202){
       // Navigator.pop(context);
        emit(AlreadyInTrip());
        errorGetBar(r.message??"Already in trip");
      }
      else{
      //  Navigator.pop(context);
        emit(FailureCreateTrip());
        errorGetBar(r.message??"something wrong");
      }
      });




     //  // with destination
     // if(flag==1){
     //   final response = await  api.createTrip(
     //       tripType: "with", fromAddress: address!, fromLng: currentLocation!.longitude!,
     //       fromLat: currentLocation!.latitude!,toAddress:location_control.text ,
     //       toLat: destination.latitude,toLng:destination.longitude );
     // }
     // //without
     // else{
     //   final response = await  api.createTrip(
     //       tripType: "without", fromAddress: address!, fromLng: currentLocation!.longitude!,
     //       fromLat: currentLocation!.latitude!);
     // }
    }
    else{
      errorGetBar("some required field is null we can't make the request");
    }

  }

  CreateScedualTripModel? createScedualTripModel;
  createScheduleTrip({required String tripType, required BuildContext context}) async {

    if (address != null && currentLocation != null && date != null && time != null) {

      emit(LoadingCreateScheduelTripState());
      loadingDialog();


      String formattedDate  =intl. DateFormat('yyyy-M-d').format(date!);
      // DateTime dateTime = DateTime(0, 1, 1, time.hour, time.minute, 0);
      String formattedTime  = '${time.hour}:${time.minute}:00';
      //

      try {

        final response = await api.createScheduleTrip(
          tripType: tripType,
          fromAddress: address!,
          fromLng: currentLocation!.longitude!.toString(),
          fromLat: currentLocation!.latitude!.toString(),
          toAddress: tripType == "with" ? location_control.text : null,
          toLat: tripType == "with" ? destination.latitude.toString() : null,
          toLng: tripType == "with" ? destination.longitude .toString(): null,

          date: formattedDate ,
          time: formattedTime
        );

        response.fold((l) {
           Navigator.pop(context);

          emit(FailureCreateSchedualTrip());
          errorGetBar("failed to create schedule trip");
        }, (r) {

          if (r.code == 200 || r.code == 201) {
            successGetBar(r.message);

            emit(SuccessCreateSchedualTripState());
           // bottomContainerLoadingState = true;

          } else {
             Navigator.pop(context);
            // Navigator.pop(context);
             errorGetBar(r.message??"something wrong");
            emit(FailureCreateSchedualTrip());
          }
        });
      } catch (e) {
        emit(FailureCreateSchedualTrip());
        errorGetBar(e.toString()??"something wrong");
      }
    }

    else {
      Navigator.pop(context);
      errorGetBar("Some required field is null. We can't make the request.");

    }
  }



     cancelTrip(BuildContext context
  ,  { int? tripId}
    )async{



    if(tripId != null){

      emit(CancelTripLoading());
      final response = await api.cancelUserTrip(tripId: tripId);
      response.fold((l) {
        errorGetBar("something wrong");
        emit(CancelTripFailure());
      }, (r) {

        emit(CancelTripSuccess());




        if(r.data!= null){

          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeRoute, (route) => false);
        }
        successGetBar(r.message);


      });

    }else{


      if(createTripModel!=null){
        emit(CancelTripLoading());
        final response = await api.cancelUserTrip(tripId: createTripModel!.data!.id!);
        response.fold((l) {
          errorGetBar("something wrong");
          emit(CancelTripFailure());
        }, (r) {

          emit(CancelTripSuccess());




          if(r.data!= null){

            Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeRoute, (route) => false);
          }
          successGetBar(r.message);


        });
      }
      else{
        errorGetBar("there is no trip to cancel it");
      }
    }

}

  //
  // double progressValue = 0.0;
  // late Timer timer;
  // final Duration duration = const Duration(minutes: 5);
  // void startTimer() {
  //   const oneSecond = const Duration(seconds: 1);
  //   timer = Timer.periodic(oneSecond, (Timer timer) {
  //       if (progressValue < 1.0) {
  //         progressValue += 1.0 / (duration.inSeconds);
  //         emit(ProgressState());
  //       } else {
  //         timer.cancel();
  //         emit(ProgressFinishState());
  //       }
  //
  //   });
  // }






  double progressValue = 0.0;
  late Timer _timer;
  final Duration _duration = const Duration(minutes: 1);
  void startTimer(BuildContext context) {
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {

        if (progressValue < 1.0) {
          progressValue += 1.0 / (_duration.inSeconds);
        } else {
          _timer.cancel();
          //currentEnumStatus = MyEnum.failure;


        }
      });
  emit(LoadingIndicatorState());
  }

  Widget chooseWidget(MyEnum state){
    switch(state){

      case MyEnum.defaultState:
        emit(changingStatus());
        return DefaultWidget(isATrip: false,);
      case MyEnum.load:
        emit(changingStatus());
        return LoadingWidget();
      case MyEnum.success:
        emit(changingStatus());
        return SuccessWidget();
      case MyEnum.failure:
        emit(changingStatus());
        return FailureWidget();
      default:
        emit(changingStatus());
        return DefaultWidget(isATrip: false,);
    }
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

  // checkDocuments
  CheckDocumentsModel checkDocumentsModel=  CheckDocumentsModel ();

  checkDocuments(BuildContext context) async {
    emit(LoadingCheckDocumentsStatus());
    final response = await api.checkDocuments();
    response.fold((l) {
      emit(FailureCheckDocumentsState());
    }, (r) {
      checkDocumentsModel = r;
      if( r.data!.driverDetails == 1 && r.data!.driverDocuments ==1){
        if ( r.data!.status ==1){
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homedriverRoute, (route) => false);
        }else
          successGetBar('ما زال طلبك معلق');
      }
      emit(SuccessCheckDocumentsState());
    });
  }


}
