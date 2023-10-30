// import 'dart:async';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:dropdown_search/dropdown_search.dart' as drop;
// import 'package:easy_localization/easy_localization.dart'as oo;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_webservice/geocoding.dart' as geocoding;
// import 'package:google_maps_webservice/places.dart';
// import 'package:hero/core/widgets/custom_button.dart';
// import 'package:location/location.dart' as loc;
// import '../../../core/utils/app_colors.dart';
// import '../../../core/utils/assets_manager.dart';
// import '../../../core/utils/getsize.dart';
// import '../../../core/widgets/back_button.dart';
// import '../components/drawer_list_item.dart';
// import '../cubit/home_cubit.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:clippy_flutter/triangle.dart';
//
// class TripWithoutDestination extends StatefulWidget {
//   TripWithoutDestination({super.key});
//
//   @override
//   State<TripWithoutDestination> createState() => _TripWithoutDestinationState();
// }
//
// class _TripWithoutDestinationState extends State<TripWithoutDestination> {
//   // final scaffoldKey = GlobalKey<ScaffoldState>();
//   final Completer<GoogleMapController> _controller = Completer();
//   GoogleMapController? mapController;
//   static LatLng sourceLocation = LatLng(31.2693, 30.7873);
//
// //  static  LatLng destination = LatLng(30.4301, 31.0364);
//   CustomInfoWindowController _customInfoWindowController =
//   CustomInfoWindowController();
//   String? payment = "cash";
//   Set<Marker> markers = {};
//   String location = "Search Location";
//
//
//   @override
//   void dispose() {
//     _customInfoWindowController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     getCurrentLocation();
//     //getPolyPoints();
//     setCustomMarkerIcon();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         HomeCubit cubit = context.read<HomeCubit>();
//         return Scaffold(
//           //  key: scaffoldKey,
//           resizeToAvoidBottomInset: false,
//           body: Stack(
//             children: [
//               currentLocation == null
//                   ? const Center(child: Text("Loading"))
//                   : GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(currentLocation!.latitude!,
//                       currentLocation!.longitude!),
//                   zoom: 13.5,
//                 ),
//                 markers:
//                 {
//                   Marker(
//                     markerId: const MarkerId("currentLocation"),
//                     icon: currentLocationIcon,
//                     position: LatLng(currentLocation!.latitude!,
//                         currentLocation!.longitude!),
//                   ),
//                   Marker(
//                     markerId: const MarkerId("source"),
//                     infoWindow: InfoWindow(title: "from",),
//                     icon: sourceIcon,
//                     position: sourceLocation,
//                   ),
//                   // Marker(
//                   //   markerId: MarkerId("destination"),
//                   //   infoWindow: InfoWindow(title: "to",),
//                   //   icon: destinationIcon,
//                   //   position: destination,
//                   // ),
//                 },
//                 onMapCreated: (mapController) {
//                   _controller.complete(mapController);
//                   _customInfoWindowController.googleMapController =
//                       mapController;
//                   this.mapController = mapController;
//                   setState(() {
//
//                   });
//                 },
//                 onTap: (argument) {
//                   _customInfoWindowController.hideInfoWindow!();
//                 },
//                 onCameraMove: (position) {
//                   _customInfoWindowController.hideInfoWindow!();
//                 },
//                 polylines: {
//                   Polyline(
//                     polylineId: const PolylineId("route"),
//                     points: polylineCoordinates,
//                     color: const Color(0xFF7B61FF),
//                     width: 6,
//                   ),
//                 },
//               ),
//               CustomInfoWindow(
//                 controller: _customInfoWindowController,
//                 height: 75,
//                 width: 150,
//                 offset: 50,
//               ),
//               //default state
//               Visibility(
//                 visible: cubit.bottomContainerInitialState,
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child:
//                   Container(
//                       height: getSize(context) * 0.55,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(30),
//                               topLeft: Radius.circular(30))),
//                       child: Column(
//                         children: [
//                           SizedBox(height: getSize(context) * 0.1,),
//                           SizedBox(height: 15,),
//                           Row(
//                             children: [
//                               SizedBox(width: 20,),
//                               Text("payment_method").tr(),
//                             ],
//                           ),
//                           RadioListTile(
//                             title: Text("cash").tr(),
//                             value: payment,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10),
//                             tileColor: AppColors.black1,
//                             activeColor: AppColors.primary,
//                             selected: true,
//                             groupValue: payment,
//                             onChanged: (value) {
//                             cubit.changeRadioButton;
//
//                             },
//                           ),
//                           //ride now or later
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               CustomButton(
//
//                                 text: "ride_later".tr(),
//                                 color: AppColors.primary,
//                                 borderRadius: 16,
//                                 onClick: () async {
//                                   await cubit.selectDateAndTime(context);
//                                 },
//                                 width: getSize(context) / 2,),
//                               Container(
//                                 //   padding: EdgeInsets.symmetric(horizontal: 1),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(
//                                         width: 3, color: AppColors.primary)
//                                 ),
//                                 child: CustomButton(
//                                   borderRadius: 16,
//                                   text: "ride_now".tr(),
//                                   color: AppColors.white,
//                                   textcolor: AppColors.primary,
//                                   onClick: () {
//                                     cubit.changeToRideNowState();
//                                   },
//                                   width: getSize(context) / 3,),
//                               )
//                             ],)
//                         ],
//                       )),
//                 ),
//               ),
//
//               // loading state
//               Visibility(
//                 visible: cubit.bottomContainerLoadingState1,
//                 //visible: false,
//                 child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: getSize(context) * 0.8,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(30),
//                           topLeft: Radius.circular(30),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Image.asset(
//                             ImageAssets.search,
//                             width: getSize(context) / 4,
//                           ),
//                           //progress indicator
//                           Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 10.0),
//                             child: LinearProgressIndicator(
//                               borderRadius: BorderRadius.circular(20),
//                               value: 0.7,
//                               color: AppColors.primary, //<-- SEE HERE
//                               backgroundColor: AppColors.grey1, //<-- SEE HERE
//                             ),
//                           ),
//                           //rich text
//                           Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 12.0),
//                             child: RichText(
//                                 textDirection: TextDirection.rtl,
//                                 text: TextSpan(
//                                     text: "search_for_drivers".tr(),
//                                     style: TextStyle(
//                                       color: AppColors.black2,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: getSize(context) * 0.04,
//                                     ),
//                                     children: [
//                                       TextSpan(
//                                         text: "appreciate_your_patience".tr(),
//                                         style: TextStyle(
//                                           color: AppColors.primary,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: getSize(context) * 0.04,
//                                         ),
//                                       )
//                                     ])),
//                           ),
//                           //button
//                           CustomButton(
//                             text: "cancel".tr(),
//                             color: AppColors.red,
//                             onClick: () {
//                               cubit.tabsController.animateTo(0);
//                               cubit.bottomContainerLoadingState = false;
//                               cubit.bottomContainerInitialState = true;
//                             },
//                             width: getSize(context) * 0.9,
//                             borderRadius: 16,
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//               //success state
//               Visibility(
//                 visible: cubit.bottomContainerSuccessState1,
//                 //visible: false,
//                 child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: getSize(context) * 0.6,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(30),
//                           topLeft: Radius.circular(30),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Image.asset(
//                             ImageAssets.success,
//                             width: getSize(context) / 4,
//                           ),
//
//                           //rich text
//                           Padding(
//                               padding:
//                               const EdgeInsets.symmetric(horizontal: 12.0),
//                               child: Text("confirm_driver".tr())
//                           ),
//                           Row(mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10,),
//                               Icon(Icons.person, color: Colors.grey,),
//                               SizedBox(width: 10,),
//                               Text("محمد محمود", style: TextStyle(
//                                   color: AppColors.black3
//                               ),)
//                             ],)
//                         ],
//                       ),
//                     )),
//               ),
//               //failure state
//               Visibility(
//                 visible: cubit.bottomContainerFailureState1,
//                 //visible: false,
//                 child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: getSize(context) * 0.55,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(30),
//                           topLeft: Radius.circular(30),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Image.asset(
//                             ImageAssets.failure,
//                             width: getSize(context) / 4,
//                           ),
//
//                           //rich text
//                           Padding(
//                               padding:
//                               const EdgeInsets.symmetric(horizontal: 12.0),
//                               child: Text("no_drivers".tr())
//                           ),
//                           //button
//                           CustomButton(
//                             text: "try_again".tr(),
//                             color: AppColors.red,
//                             onClick: () {
//                               cubit.tabsController.animateTo(0);
//                               cubit.bottomContainerLoadingState = false;
//                               cubit.bottomContainerFailureState = false;
//                               cubit.bottomContainerSuccessState = false;
//                               cubit.bottomContainerInitialState = true;
//                             },
//                             width: getSize(context) * 0.9,
//                             borderRadius: 16,
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//
//
//               Positioned(
//                 top: getSize(context) * 0.01,
//                 right: 0,
//                 left: 0,
//                 child: Padding(
//                   padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
//                   child: Row(
//                     children: [
//                       CustomBackButton(),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//
//         );
//       },
//     );
//   }
//
//   List<LatLng> polylineCoordinates = [];
//
//   // void getPolyPoints() async {
//   //   PolylinePoints polylinePoints = PolylinePoints();
//   //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//   //     "AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g", // Your Google Map Key
//   //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//   //    // PointLatLng(destination.latitude, destination.longitude),
//   //   );
//   //   if (result.points.isNotEmpty) {
//   //     result.points.forEach(
//   //           (PointLatLng point) => polylineCoordinates.add(
//   //         LatLng(point.latitude, point.longitude),
//   //       ),
//   //     );
//   //     setState(() {});
//   //   }
//   // }
//
//   loc.LocationData? currentLocation;
//
//   void getCurrentLocation() async {
//     loc.Location location = loc.Location();
//     location.getLocation().then(
//           (location) {
//         currentLocation = location;
//         sourceLocation = LatLng(location.latitude!, location.longitude!);
//         setState(() {
//           // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
//         });
//       },
//     );
//     GoogleMapController googleMapController = await _controller.future;
//     location.onLocationChanged.listen(
//           (newLoc) {
//         currentLocation = newLoc;
//         //sourceLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
//         googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               zoom: 13.5,
//               target: LatLng(
//                 newLoc.latitude!,
//                 newLoc.longitude!,
//               ),
//             ),
//           ),
//         );
//         setState(() {});
//       },
//     );
//   }
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//
//   void setCustomMarkerIcon() {
//     BitmapDescriptor.fromAssetImage(
//       ImageConfiguration.empty,
//       "assets/images/pin_source1.png",
//     ).then(
//           (icon) {
//         sourceIcon = icon;
//       },
//     );
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, "assets/images/pin_destination1.png")
//         .then(
//           (icon) {
//         destinationIcon = icon;
//       },
//     );
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration.empty, "assets/images/badge1.png")
//         .then(
//           (icon) {
//         currentLocationIcon = icon;
//       },
//     );
//   }
// }
