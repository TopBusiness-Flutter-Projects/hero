import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../components/drawer_list_item.dart';
import '../cubit/home_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class AddTripTab extends StatefulWidget {
  AddTripTab({super.key});

  @override
  State<AddTripTab> createState() => _AddTripTabState();
}

class _AddTripTabState extends State<AddTripTab> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller = Completer();
  static LatLng sourceLocation = LatLng(31.2693, 30.7873);
  static const LatLng destination = LatLng(30.4301, 31.0364);
  String? payment;
  String? gender;
  bool radioEnabled = true;

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: Stack(
        children: [
          currentLocation == null
              ? const Center(child: Text("Loading"))
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 13.5,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      icon: currentLocationIcon,
                      position: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!),
                    ),
                    Marker(
                      markerId: const MarkerId("source"),
                      infoWindow: InfoWindow(title: "from",),
                      icon: sourceIcon,
                      position: sourceLocation,
                    ),
                    Marker(
                      markerId: MarkerId("destination"),
                      infoWindow: InfoWindow(title: "to",),
                      icon: destinationIcon,
                      position: destination,
                    ),
                  },
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      points: polylineCoordinates,
                      color: const Color(0xFF7B61FF),
                      width: 6,
                    ),
                  },
                ),
          Align(
            alignment: Alignment.bottomCenter,
              // top: getSize(context)*1.5,
              // right: 0,
              // left: 0,
              child:
              Container(
                height: getSize(context)*0.6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(height: getSize(context)*0.1,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                       padding: EdgeInsets.symmetric(horizontal: 10),
                       // height: 100,
                       // width: getSize(context),
                        decoration: BoxDecoration(

                          boxShadow: [
                            BoxShadow(color: AppColors.black.withOpacity(0.25),blurRadius: 10,
                                spreadRadius: 0,offset:Offset(0,4) )
                          ],
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                          Expanded(child:   TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "select_destination".tr()
                            ),
                          ),),
                            Icon(Icons.favorite_border)
                          ],
                        ),
                      ),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         SizedBox(width: 20,),
                         Text("payment_method").tr(),
                       ],
                     ),

                      RadioListTile(
                        title: Text("cash").tr(),
                        value: "cash",
                        groupValue: gender,
                        onChanged: (value){
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      //
                      // RadioListTile(
                      //   title: Text("Female"),
                      //   value: "female",
                      //   groupValue: gender,
                      //   onChanged: (value){
                      //     setState(() {
                      //       gender = value.toString();
                      //     });
                      //   },
                      // ),
                    ],
                  )),
          ),
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
                      context.read<HomeCubit>().controller.animateTo(0);
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

  List<LatLng> polylineCoordinates = [];

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
      setState(() {});
    }
  }

  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        setState(() {
          // //  sourceLocation = LatLng(location.latitude!, location.longitude!);
        });
      },
    );
    GoogleMapController googleMapController = await _controller.future;
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
        setState(() {});
      },
    );
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
}
