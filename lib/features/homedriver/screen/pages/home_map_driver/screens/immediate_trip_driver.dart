import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../cubit/home_driver_cubit.dart';


class ImmediateTripDriver extends StatefulWidget {
  const ImmediateTripDriver({super.key});

  @override
  State<ImmediateTripDriver> createState() => _ImmediateTripDriverState();
}

class _ImmediateTripDriverState extends State<ImmediateTripDriver> {
  GoogleMapController? mapController;
  HomeDriverCubit? cubit;

  @override
  Widget build(BuildContext context) {
    cubit = context.read<HomeDriverCubit>();

    return BlocBuilder<HomeDriverCubit, HomeDriverState>(
      builder: (context, state) {
        if(state is UpdateCurrentLocationState){
          updateCameraPosition();
        }
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Builder(
                builder: (context) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        cubit!.currentLocation != null ? cubit!.currentLocation!
                            .latitude! : 0,
                        cubit!.currentLocation != null ? cubit!.currentLocation!
                            .longitude! : 0,
                      ),
                      zoom: 13.5,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        icon: cubit!.markerIcon != null
                            ? BitmapDescriptor.fromBytes(cubit!.markerIcon!)
                            : cubit!.currentLocationIcon,
                        position: LatLng(
                          cubit!.currentLocation != null ? cubit!
                              .currentLocation!.latitude! : 0,
                          cubit!.currentLocation != null ? cubit!
                              .currentLocation!.longitude! : 0,
                        ),
                      ),
                      // Rest of the markers...
                    },
                    onMapCreated: (GoogleMapController controller) {
                      mapController =
                          controller; // Store the GoogleMapController
                    },
                    onTap: (argument) {
                      // _customInfoWindowController.hideInfoWindow!();
                    },
                    onCameraMove: (position) {
                      // _customInfoWindowController.hideInfoWindow!();
                    },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        // points: cubit.polylineCoordinates,
                        color: const Color(0xFF7B61FF),
                        width: 6,
                      ),
                    },

                  );
                },


              ),

            ],
          ),
        );
      },
    );
  }

  void updateCameraPosition() {
    if (mapController != null && cubit!.currentLocation != null) {
      mapController!.animateCamera(

        CameraUpdate.newLatLng(

          LatLng(
            cubit!.currentLocation!.latitude!,
            cubit!.currentLocation!.longitude!,
          ),
        ),
      );
    }
  }
}
