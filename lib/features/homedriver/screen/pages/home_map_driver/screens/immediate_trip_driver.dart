import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/my_svg_widget.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../../../../core/widgets/custom_textfield.dart';
import '../cubit/home_driver_cubit.dart';

class ImmediateTripDriver extends StatefulWidget {
  const ImmediateTripDriver({super.key});

  @override
  State<ImmediateTripDriver> createState() => _ImmediateTripDriverState();
}

class _ImmediateTripDriverState extends State<ImmediateTripDriver> {
  HomeDriverCubit? cubit;

  @override
  Widget build(BuildContext context) {
    cubit = context.read<HomeDriverCubit>();

    return BlocBuilder<HomeDriverCubit, HomeDriverState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Builder(
                builder: (context) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        cubit!.currentLocation != null
                            ? cubit!.currentLocation!.latitude!
                            : 0,
                        cubit!.currentLocation != null
                            ? cubit!.currentLocation!.longitude!
                            : 0,
                      ),
                      zoom: 13.5,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        icon: cubit!.bitmapDescriptorfrom != null
                            ? cubit!.bitmapDescriptorfrom!
                            : cubit!.currentLocationIcon,
                        position: LatLng(
                          cubit!.currentLocation != null
                              ? cubit!.currentLocation!.latitude!
                              : 0,
                          cubit!.currentLocation != null
                              ? cubit!.currentLocation!.longitude!
                              : 0,
                        ),
                      ),
                      Marker(
                        markerId: const MarkerId("destinationLocation"),
                        icon: cubit!.bitmapDescriptorto != null
                            ? cubit!.bitmapDescriptorto!
                            : cubit!.currentLocationIcon,
                        position: LatLng(cubit!.destinaion.latitude,
                            cubit!.destinaion.longitude),
                      ),
                      // Rest of the markers...
                    },
                    onMapCreated: (GoogleMapController controller) {
                      cubit!.mapController =
                          controller;
                      // Store the GoogleMapController
                    },
                    onTap: (argument) {
                      cubit!.getLocation(argument, "to");
                      // _customInfoWindowController.hideInfoWindow!();
                    },
                    onCameraMove: (position) {

                      if (cubit!.strartlocation!=position.target){
                        print(cubit!.strartlocation);
                        cubit!.strartlocation=position.target;
                        cubit!.getCurrentLocation();}
                      // _customInfoWindowController.hideInfoWindow!();
                    },
                    polylines: {
                      Polyline(
                          polylineId: const PolylineId("route"),
                          points: cubit!.latLngList,
                          color: AppColors.black,
                          width: 5,
                          visible: true),
                    },
                  );
                },
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  left: 60,
                  child: Material(
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 40)),
                    color: AppColors.white,
                    child: CustomTextField(
                      title: 'search_location'.tr(),
                      backgroundColor: AppColors.white,
                      prefixWidget: Padding(
                        padding: EdgeInsets.all(getSize(context) / 32),
                        child: MySvgWidget(
                          path: ImageAssets.mapIcon,
                          imageColor: AppColors.black,
                          size: 10,
                        ),
                      ),
                      validatorMessage: 'loaction_msg'.tr(),
                      horizontalPadding: 2,
                      textInputType: TextInputType.text,
                      onchange: (p0) {
                        cubit!.search(p0);
                      },
                      controller: cubit!.location_control,
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
