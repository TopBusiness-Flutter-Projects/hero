import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: sourceLocation,
              zoom: 13.5,
            ),
            markers: {
              const Marker(
                markerId: MarkerId("source"),
                position: sourceLocation,
              ),
              const Marker(
                markerId: MarkerId("destination"),
                position: destination,
              ),
            },
            onMapCreated: (mapController) {
              _controller.complete(mapController);
            },
          ),
          Positioned(
            top: getSize(context)*0.1,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
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
}
