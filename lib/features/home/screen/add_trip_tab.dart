import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:dropdown_search/dropdown_search.dart'as drop;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/geocoding.dart'as geocoding;
import 'package:google_maps_webservice/places.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/home/screen/home.dart';
import 'package:location/location.dart'as loc;
import 'package:lottie/lottie.dart'as lottie;
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../components/drawer_list_item.dart';
import '../cubit/home_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:clippy_flutter/triangle.dart';
class AddTripTab extends StatefulWidget {
  AddTripTab({super.key});

  @override
  State<AddTripTab> createState() => _AddTripTabState();
}

class _AddTripTabState extends State<AddTripTab> with TickerProviderStateMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // final Completer<GoogleMapController> controller = Completer();
  // GoogleMapController? mapController;
  // static LatLng sourceLocation = LatLng(31.2693, 30.7873);
  // static  LatLng destination = LatLng(30.4301, 31.0364);
  CustomInfoWindowController _customInfoWindowController =
  CustomInfoWindowController();
 // late AnimationController lottieController;
  // String? payment = "cash";
  Set<Marker> markers = {};
  // String location = "Search Location";
 late FlutterGifController gifController;



  @override
  void dispose() {
    _customInfoWindowController.dispose();

    super.dispose();
  }
  @override
  void initState() {
    context.read<HomeCubit>().getCurrentLocation();
    //getPolyPoints();
    context.read<HomeCubit>().setCustomMarkerIcon();
    gifController= FlutterGifController(vsync: this);
   // controller1 = FlutterGifController(vsync: this);

    // lottieController = AnimationController(
    //   vsync: this,
    // );
    //
    // lottieController.addStatusListener((status) async {
    //   if (status == AnimationStatus.completed) {
    //     Navigator.pop(context);
    //     lottieController.reset();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // markers.addAll( {
    //   Marker(
    //     markerId: const MarkerId("currentLocation"),
    //     icon: currentLocationIcon,
    //     position: LatLng(currentLocation!.latitude!,
    //         currentLocation!.longitude!),
    //   ),
    //   Marker(
    //     markerId: const MarkerId("source"),
    //     infoWindow: InfoWindow(title: "from",),
    //     icon: sourceIcon,
    //     position: sourceLocation,
    //   ),
    //   Marker(
    //     markerId: MarkerId("destination"),
    //     infoWindow: InfoWindow(title: "to",),
    //     icon: destinationIcon,
    //     position: destination,
    //   ),
    // },);
    // markers.add(
    //   Marker(
    //     markerId: MarkerId("marker_id"),
    //     position: sourceLocation,
    //     onTap: () {
    //       _customInfoWindowController.addInfoWindow!(
    //         Column(
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.blue,
    //                   borderRadius: BorderRadius.circular(4),
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Icon(
    //                         Icons.account_circle,
    //                         color: Colors.white,
    //                         size: 30,
    //                       ),
    //                       SizedBox(
    //                         width: 8.0,
    //                       ),
    //                       Text(
    //                         "I am here",
    //                         style:
    //                         Theme.of(context).textTheme.headline6!.copyWith(
    //                           color: Colors.white,
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 width: double.infinity,
    //                 height: double.infinity,
    //               ),
    //             ),
    //             Triangle.isosceles(
    //               edge: Edge.BOTTOM,
    //               child: Container(
    //                 color: Colors.blue,
    //                 width: 20.0,
    //                 height: 10.0,
    //               ),
    //             ),
    //           ],
    //         ),
    //         sourceLocation
    //
    //       );
    //     },
    //   ),
    // );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    HomeCubit cubit = context.read<HomeCubit>();
    return Stack(
        children: [
          cubit.currentLocation == null
              ? const Center(child: Text("Loading"))
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(cubit.currentLocation!.latitude!,
                        cubit.currentLocation!.longitude!),
                    zoom: 13.5,
                  ),
                  markers:
                  {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      icon: cubit.currentLocationIcon,
                      position: LatLng(cubit.currentLocation!.latitude!,
                          cubit.currentLocation!.longitude!),
                    ),
                    Marker(
                      markerId: const MarkerId("source"),
                      infoWindow: InfoWindow(title: "from",),
                      icon: cubit.sourceIcon,
                      position: cubit.sourceLocation,
                    ),
                    Marker(
                      markerId: MarkerId("destination"),
                      infoWindow: InfoWindow(title: "to",),
                      icon: cubit.destinationIcon,
                      position: cubit.destination,
                    ),
                  },
                  onMapCreated: (GoogleMapController mapController) {
                    //  cubit.controller.complete(mapController);
                    // _customInfoWindowController.googleMapController = mapController;
                    // this.mapController = mapController;
                    // setState(() {
                    //
                    // });
                  },
            onTap: (argument) {
            //  _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
            //  _customInfoWindowController.hideInfoWindow!();
            },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      points: cubit.polylineCoordinates,
                      color: const Color(0xFF7B61FF),
                      width: 6,
                    ),
                  },
                ),
          // CustomInfoWindow(
          //   controller: _customInfoWindowController,
          //   height: 75,
          //   width: 150,
          //   offset: 50,
          // ),
          Visibility(
            visible:cubit.bottomContainerInitialState ,
            child: Align(
              alignment: Alignment.bottomCenter,
                child:
                Container(
                  height: getSize(context)*0.8,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Column(
                      children: [
                        SizedBox(height: getSize(context)*0.1,),
                        InkWell(
                          onTap: () async {
                            // var place = await PlacesAutocomplete.show(
                            //     context: context,
                            //     apiKey: "AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g",
                            //     mode: Mode.overlay,
                            //     types: [],
                            //     strictbounds: false,
                            //     components: [
                            //       geocoding.Component(geocoding.Component.country, 'eg')],
                            //     //google_map_webservice package
                            //     onError: (err){
                            //       print(err);
                            //     }
                            // );
                            //
                            // if(place!=null){
                            //   setState(() {
                            //     location = place.description.toString();
                            //   });
                            //
                            //   //form google_maps_webservice package
                            //   final plist = GoogleMapsPlaces(apiKey:"AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g",
                            //     apiHeaders: await GoogleApiHeaders().getHeaders(),
                            //     //from google_api_headers package
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
                            //   cubit.mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 14)));
                            //
                            //   cubit.destination = newlatlang;
                            //   cubit.getPolyPoints();
                            // }
                      await   cubit.searchOnMap(context);
                          },
                            child:Padding(
                              padding: EdgeInsets.all(15),
                              child: Card(
                                child: Container(
                                    padding: EdgeInsets.all(0),
                                    width: MediaQuery.of(context).size.width - 40,
                                    child: ListTile(
                                      title:Text(cubit.location, style: TextStyle(fontSize: 18),),
                                      trailing: Icon(Icons.search),
                                      dense: true,
                                    )
                                ),
                              ),
                            )
                          // child: Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 20),
                          //  padding: EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(color: AppColors.black.withOpacity(0.25),blurRadius: 10,
                          //           spreadRadius: 0,offset:Offset(0,4) )
                          //     ],
                          //     color: AppColors.white,
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),

                            // child: Row(
                            //   children: [
                            //     Icon(Icons.location_on_outlined),
                            //   Expanded(child:   TextField(
                            //     decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       hintText:location,
                            //       //"select_destination".tr()
                            //     ),
                            //   ),),
                            //     Icon(Icons.favorite_border)
                            //   ],
                            // ),
                        //  ),
                        ),
                       SizedBox(height: 15,),
                       //payment_method
                       Row(
                         children: [
                           SizedBox(width: 20,),
                           Text("payment_method").tr(),
                         ],
                       ),
                        //cash
                        RadioListTile(
                          title: Text("cash").tr(),
                          value: cubit.payment,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        tileColor: AppColors.black1,
                          activeColor: AppColors.primary,
                          selected: true,
                          groupValue: cubit.payment,
                          onChanged: (value){
                            cubit.changeRadioButton(value);
                           //  setState(() {
                           //    payment = value.toString();
                           //  }
                           // );
                         },
                        ),
                        //SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //ride_later
                          CustomButton(
                            text: "ride_later".tr(),
                            color: AppColors.primary,
                            borderRadius: 16,
                            onClick: ()async {
                           await   cubit.selectDateAndTime(context);
                          },
                          width: getSize(context)/2,),
                          //  ride_now"
                          Container(
                         //   padding: EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 3,color: AppColors.primary)
                            ),
                            child: CustomButton(
                              borderRadius: 16,
                              text: "ride_now".tr(),
                              color: AppColors.white,
                              textcolor: AppColors.primary,
                              onClick: () {
                                showPopUp(context);
                              },
                              width: getSize(context)/3,),
                          )
                        ],)
                      ],
                    )),
            ),
          ),
          //todo => other visible states












          //back button
          Positioned(
            top: getSize(context) * 0.1,
            right: 0,
            left: 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<HomeCubit>().tabsController.animateTo(0);
                    },
                    child: Image.asset(
                      ImageAssets.backImage,
                      height: getSize(context) / 13,
                      width: getSize(context) / 13,

                      // height: getSize(context) / 1.2,
                      // width: getSize(context) / 1.2,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      //todo
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(0.25),
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.all(
                                Radius.circular(getSize(context) / 80)),
                            color: AppColors.white),
                        child: Icon(
                          Icons.menu,
                          size: 20,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      );
  },
),

      //Drawer
      drawer: Drawer(
        child: Column(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: getSize(context) * 0.1,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "محمد",
                    style: TextStyle(
                        fontSize: getSize(context) * 0.03,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black2),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        ImageAssets.close,
                        width: getSize(context) * 0.04,
                      ))
                ],
              ),
              leading: CircleAvatar(
                radius: getSize(context) * 0.1,
                backgroundImage: AssetImage(ImageAssets.person),
              ),
              subtitle: Text(
                "info@examble.com",
                style: TextStyle(
                    fontSize: getSize(context) * 0.03,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black2),
              ),
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return DrawerListItem(
                        drawerItemModel: drawerItems[index],
                        textColor: index != drawerItems.length - 1
                            ? AppColors.black1
                            : AppColors.red,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: drawerItems.length)),
          ],
        ),
      ),
    );
  }

  // List<LatLng> polylineCoordinates = [];
  //
  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g", // Your Google Map Key
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //       (PointLatLng point) => polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     setState(() {});
  //   }
  // }
  //
  // loc.LocationData? currentLocation;
  //
  // void getCurrentLocation() async {
  //   loc.Location location = loc.Location();
  //   location.getLocation().then(
  //     (location) {
  //       currentLocation = location;
  //       sourceLocation = LatLng(location.latitude!, location.longitude!);
  //       setState(() {
  //         // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
  //       });
  //     },
  //   );
  //   GoogleMapController googleMapController = await _controller.future;
  //   location.onLocationChanged.listen(
  //     (newLoc) {
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
  //       setState(() {});
  //     },
  //   );
  // }
  //
  // BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  //
  // void setCustomMarkerIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration.empty,
  //     "assets/images/pin_source1.png",
  //   ).then(
  //     (icon) {
  //       sourceIcon = icon;
  //     },
  //   );
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/images/pin_destination1.png")
  //       .then(
  //     (icon) {
  //       destinationIcon = icon;
  //     },
  //   );
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/images/badge1.png")
  //       .then(
  //     (icon) {
  //       currentLocationIcon = icon;
  //     },
  //   );
  // }
  //
  // DateTime _date = new DateTime.now();
  // TimeOfDay _time = new TimeOfDay.now();
  //
  // Future<Null> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _date,
  //     firstDate: new DateTime(2023),
  //     lastDate: new DateTime(2025),
  //   );
  //
  //   if(picked != null && picked != _date) {
  //     print('Date selected: ${_date.toString()}');
  //     setState((){
  //       _date = picked;
  //     });
  //   }
  // }
  //
  // Future<Null> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //
  //   if(picked != null && picked != _time) {
  //     print('Time selected: ${_time.toString()}');
  //     setState((){
  //       _time = picked;
  //     });
  //   }
  // }
  //
  //
  // Future<Null> _selectDateAndTime(BuildContext context) async {
  //   await _selectDate(context);
  //   await _selectTime(context);
  // }
//ride now
  showPopUp(BuildContext context){
    showDialog(
      context: context,
        builder: (context) {
          return Container(

           // height: getSize(context)*0.8,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(30) ,
                  topRight: Radius.circular(30),
              )
            ),
           // child:
            // GifImage(
            //   controller: controller1,
            //   width: 200,
            //   height: 200,
            //   image: AssetImage("assets/gif/animation.gif",),
            // )
            //*********************************************
            // Image.asset(
            //   "assets/gif/animation.gif",
            //   height: 125.0,
            //   width: 125.0,
            // ),

            // lottie.Lottie.asset("assets/lottie/search.json",
            //     repeat: false,
            //     height: 200,
            //     width: 200,
            //     controller: lottieController,
            //     onLoaded: (composition) {
            //       lottieController.duration = composition.duration;
            //       lottieController.forward();
            //     }),
          );
        },
    );
  }
}
