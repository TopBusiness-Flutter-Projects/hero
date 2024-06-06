import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/driver_trip/cubit/driver_trip_cubit.dart';
import 'package:hero/features/homedriver/cubit/home_driver_cubit.dart';
import 'package:hero/features/homedriver/screen/widgets/custom_from_to_widget.dart';
import 'package:hero/features/homedriver/screen/widgets/finish_trip_sheet.dart';
import 'package:hero/features/trip_details/cubit/trip_details_cubit.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/models/start_new_trip_model.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/assets_manager.dart';
import '../../../../../../core/widgets/custom_button.dart';

class QuickTripScreen extends StatefulWidget {
  const QuickTripScreen({super.key, required this.trip});

  final NewTrip trip;

  @override
  State<QuickTripScreen> createState() => _QuickTripScreenState();
}

class _QuickTripScreenState extends State<QuickTripScreen> {
  @override
  void initState() {
    // context.read<HomeDriverCubit>().setMarkerIcon(widget.trip.toAddress??" ", LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065")),
    //     LatLng(double.parse(widget.trip.toLat??"31.98354"), double.parse(widget.trip.toLong??"31.1234065")));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeDriverCubit cubit = context.read<HomeDriverCubit>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<HomeDriverCubit, HomeDriverState>(
            listener: (context, state) {
              if (state is SuccessEndTripState) {}
            },
            builder: (context, state) => Column(
              children: [
                Flexible(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  cubit.currentLocation != null
                                      ? cubit.currentLocation!.latitude!
                                      : 0,
                                  cubit.currentLocation != null
                                      ? cubit.currentLocation!.longitude!
                                      : 0,
                                ),
                                zoom: 17,
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId("currentLocation"),
                                  icon: cubit!.markerIcon != null
                                      ? BitmapDescriptor.fromBytes(
                                          cubit!.markerIcon!)
                                      : cubit!.currentLocationIcon,
                                  // icon: cubit.bitmapDescriptorfrom != null
                                  //     ? cubit.bitmapDescriptorfrom!
                                  //     : cubit.currentLocationIcon,
                                  position: LatLng(
                                    cubit.currentLocation != null
                                        ? cubit.currentLocation!.latitude!
                                        : 0,
                                    cubit.currentLocation != null
                                        ? cubit.currentLocation!.longitude!
                                        : 0,
                                  ),
                                ),
                                Marker(
                                  markerId:
                                      const MarkerId("destinationLocation"),
                                  // icon: cubit.bitmapDescriptorto != null
                                  //     ? cubit.bitmapDescriptorto!
                                  //     : cubit.currentLocationIcon,
                                  position: LatLng(cubit.destinaion.latitude,
                                      cubit.destinaion.longitude),
                                ),
                                // Marker(
                                //   markerId: const MarkerId("destinationLocation"),
                                //   icon: cubit.bitmapDescriptorto != null
                                //       ? cubit.bitmapDescriptorto!
                                //       : cubit.currentLocationIcon,
                                //   position: LatLng(cubit.destinaion.latitude,
                                //       cubit.destinaion.longitude),
                                // ),
                                // Rest of the markers...
                              },
                              onMapCreated: (GoogleMapController controller) {
                                cubit.mapController =
                                    controller; // Store the GoogleMapController
                              },
                              onCameraMove: (position) {
                                if (cubit.strartlocation != position.target) {
                                  print(cubit.strartlocation);
                                  cubit.strartlocation = position.target;
                                  cubit.getCurrentLocation();
                                }
                                // _customInfoWindowController.hideInfoWindow!();
                              },
                              polylines: {
                                Polyline(
                                    polylineId: const PolylineId("route"),
                                    points: cubit.latLngList,
                                    color: AppColors.black,
                                    width: 5,
                                    visible: true),
                              },
                            ),
                            Positioned(
                              bottom: 80,
                              left: 40,
                              child: GestureDetector(
                                onTap: () {
                                  cubit.mapController!.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: LatLng(
                                      cubit.currentLocation != null
                                          ? cubit.currentLocation!.latitude!
                                          : 0,
                                      cubit.currentLocation != null
                                          ? cubit.currentLocation!.longitude!
                                          : 0,
                                    ),
                                    zoom: 17,
                                  )));
                                },
                                child: Container(
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Icon(
                                        Icons.my_location,
                                        size: 30,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      // GoogleMap(
                      //   initialCameraPosition: CameraPosition(
                      //     target: LatLng(
                      //         double.parse(widget.trip.fromLat ?? "31.1234"),
                      //         double.parse(
                      //             widget.trip.fromLong ?? "31.098765")),
                      //     zoom: 13.5,
                      //   ),
                      //   markers: {
                      //     Marker(
                      //       markerId: MarkerId("from"),
                      //       position: LatLng(double.parse(widget.trip.fromLat!),
                      //           double.parse(widget.trip.fromLong!)),
                      //     ),
                      //     Marker(
                      //       markerId: MarkerId("to"),
                      //       position: LatLng(double.parse(widget.trip.toLat!),
                      //           double.parse(widget.trip.toLong!)),
                      //     ),
                      //   },
                      //   polylines: {
                      //     Polyline(
                      //       polylineId: const PolylineId("route"),
                      //       points: [
                      //         LatLng(double.parse(widget.trip.fromLat!),
                      //             double.parse(widget.trip.fromLong!)),
                      //         LatLng(double.parse(widget.trip.toLat!),
                      //             double.parse(widget.trip.toLong!)),
                      //       ],
                      //       color: const Color(0xFF7B61FF),
                      //       width: 6,
                      //     ),
                      //   },
                      // )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: getSize(context) * 0.02),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: cubit.tripStages == 0
                            ? EndTripWidget(widget: widget)
                            : Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      blurRadius: 20,
                                      offset: Offset(0, 0), // Shadow position
                                    ),
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      blurRadius: 10,
                                      offset: Offset(0, 0), // Shadow position
                                    ),
                                  ],
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      CustomFromToWidget(
                                        withName: false,
                                        name: widget.trip.name!,
                                        to: widget.trip.toAddress!,
                                        from: widget.trip.fromAddress!,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("rideTime".tr()),
                                              Text(
                                                  '${cubit.startTime!.hour}:${cubit.startTime!.minute}'),
                                            ],
                                          ),
                                          Image.asset(
                                            ImageAssets.finishTripBike,
                                          ),
                                          Column(
                                            children: [
                                              Text("arrivalTime".tr()),
                                              Text(
                                                  '${cubit.arrivalTime!.hour}:${cubit.arrivalTime!.minute}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FinishTripColumn(
                                            path: ImageAssets.finishTripMap,
                                            text: cubit.tripDistance,
                                          ),
                                          FinishTripColumn(
                                            path: ImageAssets.finishTripTime,
                                            text: cubit.tripTime,
                                          ),
                                          FinishTripColumn(
                                              path: ImageAssets.finishTripMoney,
                                              text:
                                                  "${double.parse(double.parse(cubit.endQuickTripModel.data!.price!.toString()).toStringAsFixed(2))}"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: getSize(context) * 0.02),
                    cubit.tripStages == 0
                        ? CustomButton(
                            text: 'endTrip'.tr(),
                            color: AppColors.primary,
                            onClick: () {
                              cubit.endQuickTrip(context);
                            },
                            width: getSize(context) * 0.9,
                            height: getSize(context) * 0.14,
                          )
                        : CustomButton(
                            text: 'confirm'.tr(),
                            color: AppColors.primary,
                            onClick: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.homedriverRoute, (route) => false);
                              cubit.setInitial();
                            },
                            width: getSize(context) * 0.9,
                            height: getSize(context) * 0.14,
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EndTripWidget extends StatelessWidget {
  const EndTripWidget({
    super.key,
    required this.widget,
  });

  final QuickTripScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.person_circle_fill,
              color: Colors.grey,
              size: 45,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.trip.name!,
              style: TextStyle(
                  color: AppColors.black1,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        Row(
          children: [
            SvgPicture.asset(ImageAssets.fromToIcon),
            SizedBox(
              width: 10,
            ),
            Text(
              "from".tr(),
              style: TextStyle(
                  color: AppColors.black1,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        //dash
        Row(children: [
          SizedBox(
            width: getSize(context) * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Dash(
                direction: Axis.vertical,
                length: 40,
                dashLength: 4,
                dashColor: Colors.black),
          ),
          SizedBox(
            width: 3,
          ),
          Flexible(
            child: Text(
              " ${widget.trip.fromAddress}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.gray,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ]),
        //to
        Row(
          children: [
            SvgPicture.asset(ImageAssets.toIcon),
            SizedBox(
              width: 10,
            ),
            Text(
              "to".tr(),
              style: TextStyle(
                  color: AppColors.black1,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        //معهد الكبد القومى
        Row(
          children: [
            SizedBox(
              width: getSize(context) * 0.03,
            ),
            Flexible(
              child: Text(
                "${widget.trip.toAddress}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.gray,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
