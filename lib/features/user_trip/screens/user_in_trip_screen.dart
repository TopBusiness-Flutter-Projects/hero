import 'dart:async';

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
import 'package:hero/features/user_trip/screens/widgets/driver_accept_trip_widget.dart';
import 'package:hero/features/user_trip/screens/widgets/trip_completed_widget.dart';
import 'package:hero/features/user_trip/screens/widgets/trip_in_progress_widget.dart';
import 'package:hero/features/user_trip/screens/widgets/waiting_driver_widget.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_button.dart';
import '../../home/cubit/home_cubit.dart';
import '../cubit/user_trip_cubit.dart';

class UserTripScreen extends StatefulWidget {
  const UserTripScreen({super.key,required this.trip});
  final NewTrip trip ;
  @override
  State<UserTripScreen> createState() => _UserTripScreenState();
}

class _UserTripScreenState extends State<UserTripScreen> {

  @override
  void initState() {
    context.read<HomeCubit>().getTripStatus();
    context.read<UserTripCubit>().getWaitingDriverStage();

    Timer.periodic(Duration(seconds: 10), (timer) {

        context.read<HomeCubit>().getTripStatus();
    });
    context.read<UserTripCubit>().setMarkerIcon(widget.trip.toAddress??" ", LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065")),
        LatLng(double.parse(widget.trip.toLat??"31.98354"), double.parse(widget.trip.toLong??"31.1234065")));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   UserTripCubit cubit = context.read<UserTripCubit>();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserTripCubit,UserTripState>(
          listener: (context, state) {
            if (context.read<HomeCubit>().checkTripStatusModel.data != null){

            }

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
                      // height: getSize(context) * 1.2,
                      child:  BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                         // if(state is SuccessCreateSchedualTripState ){
                         //   Navigator.pop(context);
                         // }
                        },
                        builder: (context, state) =>  GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              context.read<HomeCubit>().currentLocation != null
                                  ? context.read<HomeCubit>().currentLocation!.latitude!
                                  : 0,
                              context.read<HomeCubit>().currentLocation != null
                                  ? context.read<HomeCubit>().currentLocation!.longitude!
                                  : 0,
                            ),
                            zoom: 13.5,
                          ),
                          markers: context.read<HomeCubit>().markers,
                          //       {
                          //         Marker(
                          //           markerId: const MarkerId("currentLocation"),
                          //           icon: cubit.currentLocationIcon,
                          //
                          //           position: LatLng(cubit.currentLocation!.latitude!,
                          //               cubit.currentLocation!.longitude!),
                          //         ),
                          //         // Marker(
                          //         //   markerId: const MarkerId("source"),
                          //         //   infoWindow: InfoWindow(
                          //         //     title: "from",
                          //         //   ),
                          //         //  // icon: customMarkerIcon,
                          //         //   icon: cubit.sourceIcon,
                          //         //   position: cubit.sourceLocation,
                          //         // ),
                          //         Marker(
                          //           markerId: MarkerId("destination"),
                          //           infoWindow: InfoWindow(
                          //             title: "to",
                          //           ),
                          //           icon: cubit.destinationIcon,
                          //           position: cubit.destinationH,
                          //         ),
                          //       //  markers.first
                          //       },
                          onMapCreated: (GoogleMapController mapController) {
                            context.read<HomeCubit>().mapController = mapController;
                          },
                          onTap: (argument) {

                           // cubit.getLocation(argument, "to");
                            //  if(cubit.currentEnumStatus == MyEnum.defaultState){
                            // if (context.read<HomeCubit>().flag == 1) {
                            //   //   cubit.getLocation(argument);
                            //
                            // } else {}
                            // // }





                            //  _customInfoWindowController.hideInfoWindow!();
                          },
                          onCameraMove: (position) {
                            if (cubit.strartlocation != position.target) {
                              // print(cubit.strartlocation);
                              context.read<HomeCubit>().strartlocation = position.target;
                              context.read<HomeCubit>().getCurrentLocation();
                            }
                            // _customInfoWindowController.hideInfoWindow!();

                            //  _customInfoWindowController.hideInfoWindow!();
                          },
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("route"),
                              points: context.read<HomeCubit>().latLngList,
                              color: const Color(0xFF7B61FF),
                              width: 6,
                            ),
                          },
                        ),
                      ),
                      // child: GoogleMap(
                      //   initialCameraPosition: CameraPosition(
                      //     target:LatLng(double.parse(widget.trip.fromLat??"31.1234"),double.parse(widget.trip.fromLong??"31.098765")),
                      //     //LatLng(31.1234, 31.098765),
                      //     zoom: 12,
                      //   ),
                      //   markers:
                      //   // context.read<TripDetailsCubit>().markers,
                      //   {
                      //     Marker(markerId: MarkerId("from"),
                      //       position: LatLng(double.parse(widget.trip.fromLat!),double.parse(widget.trip.fromLong!)),),
                      //     Marker(markerId: MarkerId("to"),
                      //       position: LatLng(double.parse(widget.trip.toLat!),double.parse(widget.trip.toLong!)),),
                      //   }
                      //   ,
                      //   polylines: {
                      //     Polyline(
                      //       polylineId: const PolylineId("route"),
                      //       points: [
                      //         LatLng(double.parse(widget.trip.fromLat!), double.parse(widget.trip.fromLong!)),
                      //         LatLng(double.parse(widget.trip.toLat!),double.parse(widget.trip.toLong!)),
                      //       ],
                      //       color: const Color(0xFF7B61FF),
                      //       width: 6,
                      //     ),
                      //   },
                      // ),
                    ),
                    //  SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              ImageAssets.backImage,
                              color: AppColors.grey3,
                              height: getSize(context) / 15,
                              width: getSize(context) / 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


          BlocConsumer<HomeCubit,HomeState>(
              listener: (context, state) {
                if (context.read<HomeCubit>().checkTripStatusModel.data != null){

                  if(context.read<HomeCubit>().checkTripStatusModel.data!.type =='accept'){
                    cubit.getDriverAcceptTripStage();

                  }else if(context.read<HomeCubit>().checkTripStatusModel.data!.type =='progress'){
                    cubit.getDriverStartTripStage();
                  }
                  else if(context.read<HomeCubit>().checkTripStatusModel.data!.type =='complete'){
                    cubit. getCompletedStage();
                   // Navigator.pushNamed(
                   //     context, Routes.tripDetailsRoute,
                   //     arguments:
                   //     context.read<HomeCubit>().checkTripStatusModel.data);
                  }
                  else if(context.read<HomeCubit>().checkTripStatusModel.data!.type =='new'){
                    cubit. getWaitingDriverStage();
                   // Navigator.pushNamed(
                   //     context, Routes.tripDetailsRoute,
                   //     arguments:
                   //     context.read<HomeCubit>().checkTripStatusModel.data);
                  }
                }
              },
              builder: (context, state)  {
                  return Column(
                    children: [
                      SizedBox(height: getSize(context) * 0.02),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:

                            cubit.tripStages ==2   ?
                            TripINProgressWidget()
                                :
                            cubit.tripStages ==1   ?
                            DriverAcceptWidget():
                            cubit.tripStages ==0   ?
                            WaitingDriverWidget()
                           :
                            cubit.tripStages ==3   ?
                TripCompletedWidget(trip: context.read<HomeCubit>().checkTripStatusModel.data!,)

                          :  Container(child: null,)
                          ,
                        ),
                      ),

                    ],
                  );
                }
              )

            ],
          ),
        ),
      ),
    );
  }
}
