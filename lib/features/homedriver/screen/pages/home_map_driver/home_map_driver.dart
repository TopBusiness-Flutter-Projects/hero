import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

class HomeMapDriver extends StatefulWidget {
  const HomeMapDriver({super.key});

  @override
  State<HomeMapDriver> createState() => _HomeMapDriverState();
}

class _HomeMapDriverState extends State<HomeMapDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              // target: LatLng(
              //  ),
              zoom: 13.5, target: LatLng(0, 0),
            ),
            // markers: {
            //   Marker(
            //     markerId: const MarkerId("currentLocation"),
            //     icon: cubit.currentLocationIcon,
            //
            //     position: LatLng(cubit.currentLocation!.latitude!,
            //         cubit.currentLocation!.longitude!),
            //   ),
            //   Marker(
            //     markerId: const MarkerId("source"),
            //     infoWindow: InfoWindow(
            //       title: "from",
            //     ),
            //     // icon: customMarkerIcon,
            //     icon: cubit.sourceIcon,
            //     position: cubit.sourceLocation,
            //   ),
            //   Marker(
            //     markerId: MarkerId("destination"),
            //     infoWindow: InfoWindow(
            //       title: "to",
            //     ),
            //     icon: cubit.destinationIcon,
            //     position: cubit.destination,
            //   ),
            //   //  markers.first
            // },
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
                // points: cubit.polylineCoordinates,
                color: const Color(0xFF7B61FF),
                width: 6,
              ),
            },
          ),
          Positioned(
            top: 20,
right: 0,
              left: 0,
              child: Material(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.white,
            child: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.circle_fill,
                    size: 10,
                    color: AppColors.success,
                  ),
                  Text("you_conect",
                  style: TextStyle(fontSize: getSize(context)/24,color: AppColors.success,),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
