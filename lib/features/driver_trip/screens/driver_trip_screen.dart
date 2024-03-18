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
import 'package:hero/features/trip_details/cubit/trip_details_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/back_button.dart';
import '../../../core/widgets/custom_button.dart';
import '../../home/cubit/home_cubit.dart';
import '../../homedriver/cubit/home_driver_cubit.dart';

class DriverTripScreen extends StatefulWidget {
  const DriverTripScreen({super.key, required this.trip});

  final NewTrip trip;

  @override
  State<DriverTripScreen> createState() => _DriverTripScreenState();
}

class _DriverTripScreenState extends State<DriverTripScreen> {
  @override
  void initState() {
    if (widget.trip.tripType != 'without') {
      //with
      context.read<DriverTripCubit>().setMarkerIcon(
          widget.trip.toAddress ,
          LatLng(double.parse(widget.trip.fromLat ?? "31.98354"),
              double.parse(widget.trip.fromLong ?? "31.1234065")),
          LatLng(double.parse(widget.trip.toLat ?? "31.98354"),
              double.parse(widget.trip.toLong ?? "31.1234065"))
      ,       context,
      widget.trip.fromAddress!);
if(context.read<DriverTripCubit>().tripStages ==1){
  context.read<DriverTripCubit>().getDirection(//widget.trip
      LatLng( context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
          .currentLocation!.latitude! : 0,
        context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
            .currentLocation!.longitude! : 0,),
      LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065"))
  );

}else if(context.read<DriverTripCubit>().tripStages ==2){
  context.read<DriverTripCubit>().getDirection(//widget.trip
      LatLng( context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
          .currentLocation!.latitude! : 0,
        context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
            .currentLocation!.longitude! : 0,),
      LatLng(double.parse(widget.trip.toLat??"31.98354"), double.parse(widget.trip.toLong??"31.1234065"))
  );
}

    } else
      {
        context.read<DriverTripCubit>().setMarkerIcon(
            null,
            LatLng(double.parse(widget.trip.fromLat ?? "31.98354"),
                double.parse(widget.trip.fromLong ?? "31.1234065")),
            null,context,

            widget.trip.fromAddress!
        );
        if(context.read<DriverTripCubit>().tripStages ==0){
          context.read<DriverTripCubit>().getDirection(//widget.trip
              LatLng( context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
                  .currentLocation!.latitude! : 0,
                context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
                    .currentLocation!.longitude! : 0,),
              LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065"))
          );

        }

      }

    context.read<DriverTripCubit>().getDirectionFromTo(//widget.trip
        LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065")),
        LatLng(double.parse(widget.trip.toLat??"31.98354"), double.parse(widget.trip.toLong??"31.1234065"))
    );

    context.read<DriverTripCubit>().getDirection(//widget.trip
 LatLng( context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
     .currentLocation!.latitude! : 0,
   context.read<HomeDriverCubit>().currentLocation != null ? context.read<HomeDriverCubit>()
       .currentLocation!.longitude! : 0,),
 LatLng(double.parse(widget.trip.toLat??"31.98354"), double.parse(widget.trip.toLong??"31.1234065"))
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DriverTripCubit cubit = context.read<DriverTripCubit>();
    HomeDriverCubit homeDriverCubit = context.read<HomeDriverCubit>();
    return WillPopScope(
      onWillPop: () async {
        if(cubit.tripStages==0)
          return true;
        else
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<DriverTripCubit, DriverTripState>(
            listener: (context, state) {
              if (state is SuccessEndTripState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: getSize(context) * 0.05,
                            ),
                            //close
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.homedriverRoute,
                                          (route) => false);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: SvgPicture.asset(ImageAssets.close),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: getSize(context) * 0.03,
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (double rating) {
                                print(rating);
                                cubit.rate = rating;
                              },
                            ),
                            SizedBox(
                              height: getSize(context) * 0.03,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: cubit.commentController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    hintText: "write_comment".tr(),
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: getSize(context) * 0.03,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                print('fffffffffffff');
                                print(widget.trip.id!);
                                print(widget.trip.user!.id!);
                                print(cubit.rate);
                                print(widget.trip.id!);
                                print('fffffffffffff');

                                cubit.rateUser(
                                    context,
                                    widget.trip.id.toString(),
                                    cubit.rate.toString(),
                                    widget.trip.user!.id.toString(),
                                    cubit.commentController.text);

                                // cubit.giveRate(tripId: widget.trip.id!,
                                //     toId: widget.trip.user!.id!,
      //
                                //     description: cubit.commentController.text,context: context);
                                //   Navigator.pop(context);
                              },
                              child: Text(
                                "confirm".tr(),
                                style: TextStyle(color: AppColors.green1),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.greenLight,
                                  minimumSize: Size(getSize(context) * 0.3,
                                      getSize(context) * 0.1)),
                            ),
                            SizedBox(
                              height: getSize(context) * 0.03,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
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
                        child: BlocConsumer<HomeDriverCubit,HomeDriverState>(
                          listener: (context, state) {
                          if (state is LocationChangedState){
                            print('yyyyyyyy');
                          }
                          },
                          builder: (context,state) {
                            return GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  homeDriverCubit.currentLocation != null ? homeDriverCubit.currentLocation!
                                      .latitude! : 0,
                                  homeDriverCubit.currentLocation != null ? homeDriverCubit.currentLocation!
                                      .longitude! : 0,
                                ),
                                zoom: 13.5,
                              ),
                              markers:  widget.trip.tripType != 'without' ?

                                  cubit.tripStages == 1?
                                  {
                                    Marker(
                                      markerId: const MarkerId("currentLocation"),
                                      icon: homeDriverCubit.markerIcon != null
                                          ? BitmapDescriptor.fromBytes(homeDriverCubit.markerIcon!)
                                          : homeDriverCubit.currentLocationIcon,
                                      position: LatLng(
                                        homeDriverCubit.currentLocation != null ? homeDriverCubit
                                            .currentLocation!.latitude! : 0,
                                        homeDriverCubit.currentLocation != null ? homeDriverCubit
                                            .currentLocation!.longitude! : 0,
                                      ),
                                    ),


                                    Marker(
                                      markerId: MarkerId("from"),
                                      position: LatLng(double.parse(widget.trip.fromLat!),
                                          double.parse(widget.trip.fromLong!)),
                                    ),



                                    // Rest of the markers...
                                  }
                                      :
                                  cubit.tripStages == 2?
                                  {

                                    Marker(
                                      markerId: const MarkerId("currentLocation"),
                                      icon: homeDriverCubit!.markerIcon != null
                                          ? BitmapDescriptor.fromBytes(homeDriverCubit.markerIcon!)
                                          : homeDriverCubit!.currentLocationIcon,
                                      position: LatLng(
                                        homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                            .currentLocation!.latitude! : 0,
                                        homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                            .currentLocation!.longitude! : 0,
                                      ),
                                    ),

                                    Marker(
                                      markerId: MarkerId("to"),
                                      position: LatLng(double.parse(widget.trip.toLat!),
                                          double.parse(widget.trip.toLong!)),
                                    ),



                                    // Rest of the markers...
                                  }
                                      :
      // on start screen
                              {
                                Marker(
                                  markerId: const MarkerId("currentLocation"),
                                  icon: homeDriverCubit!.markerIcon != null
                                      ? BitmapDescriptor.fromBytes(homeDriverCubit.markerIcon!)
                                      : homeDriverCubit!.currentLocationIcon,
                                  position: LatLng(
                                    homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                        .currentLocation!.latitude! : 0,
                                    homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                        .currentLocation!.longitude! : 0,
                                  ),
                                ),
      // cubit.bitmapDescriptorfrom != null ?Marker(
      //   markerId: MarkerId("from"),
      //   icon:cubit.bitmapDescriptorfrom!,
      //   position: LatLng(double.parse(widget.trip.fromLat!),
      //       double.parse(widget.trip.fromLong!)),
      // ):
                                Marker(
                                  markerId: MarkerId("from"),
                                 // icon:cubit.bitmapDescriptorfrom!,
                                  position: LatLng(double.parse(widget.trip.fromLat!),
                                      double.parse(widget.trip.fromLong!)),
                                ),

                                Marker(
                                  markerId: MarkerId("to"),
                                 // icon:cubit.bitmapDescriptorto!,
                                  position: LatLng(double.parse(widget.trip.toLat!),
                                      double.parse(widget.trip.toLong!)),
                                ),

                                // Rest of the markers...
                              }

                                  :
      /// without trip
      //                             cubit.tripStages ==1 ?
      //                             {
      //                               Marker(
      //                                 markerId: const MarkerId("currentLocation"),
      //                                 icon: homeDriverCubit.markerIcon != null
      //                                     ? BitmapDescriptor.fromBytes(homeDriverCubit.markerIcon!)
      //                                     : homeDriverCubit.currentLocationIcon,
      //                                 position: LatLng(
      //                                   homeDriverCubit.currentLocation != null ? homeDriverCubit
      //                                       .currentLocation!.latitude! : 0,
      //                                   homeDriverCubit.currentLocation != null ? homeDriverCubit
      //                                       .currentLocation!.longitude! : 0,
      //                                 ),
      //                               ),
      //                               // Rest of the markers...
      //                             }
      //                                 :

                                  {
                                    Marker(
                                      markerId: const MarkerId("currentLocation"),
                                      icon: homeDriverCubit.markerIcon != null
                                          ? BitmapDescriptor.fromBytes(homeDriverCubit.markerIcon!)
                                          : homeDriverCubit.currentLocationIcon,
                                      position: LatLng(
                                        homeDriverCubit.currentLocation != null ? homeDriverCubit
                                            .currentLocation!.latitude! : 0,
                                        homeDriverCubit.currentLocation != null ? homeDriverCubit
                                            .currentLocation!.longitude! : 0,
                                      ),
                                    ),


                                    Marker(
                                      markerId: MarkerId("from"),
                                      position: LatLng(double.parse(widget.trip.fromLat!),
                                          double.parse(widget.trip.fromLong!)),
                                    ),

                                    // Rest of the markers...
                                  },
                              onMapCreated: (GoogleMapController controller) {
                                homeDriverCubit.mapController =
                                    controller; // Store the GoogleMapController
                              },
                              onTap: (argument) {
                                // _customInfoWindowController.hideInfoWindow!();
                              },
                                polylines: widget.trip.tripType != 'without'
                                    ?

                                cubit.tripStages ==1?
                                {



                                  Polyline(
                                    polylineId: const PolylineId("route"),
                                    points:cubit.latLngListTrip
                                   // [
                                   //   LatLng(
                                   //     homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                   //         .currentLocation!.latitude! : 0,
                                   //     homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                   //         .currentLocation!.longitude! : 0,
                                   //   ),
                                   //   LatLng(double.parse(widget.trip.fromLat!),
                                   //       double.parse(widget.trip.fromLong!)),
                                   // ]
                                    ,
                                    color: const Color(0xFF7B61FF),
                                    width: 6,
                                  ),}



                                    :
                                cubit.tripStages ==2?
                                {

                                  Polyline(
                                    polylineId: const PolylineId("route"),
                                    points:cubit.latLngListTrip
                                    // points: [
                                    //   LatLng(
                                    //     homeDriverCubit.currentLocation != null ? homeDriverCubit
                                    //         .currentLocation!.latitude! : 0,
                                    //     homeDriverCubit.currentLocation != null ? homeDriverCubit
                                    //         .currentLocation!.longitude! : 0,
                                    //   ),
                                    //   LatLng(double.parse(widget.trip.toLat!),
                                    //       double.parse(widget.trip.toLong!)),
                                    // ]
                                    ,
                                    color: const Color(0xFF7B61FF),
                                    width: 6,
                                  ),}
                                    :

                                {



                                  Polyline(
                                  polylineId: const PolylineId("route"),
                                    points:cubit.latLngListFromToTrip
                                  // points: [
                                  //   LatLng(double.parse(widget.trip.fromLat!),
                                  //       double.parse(widget.trip.fromLong!)),
                                  //   LatLng(double.parse(widget.trip.toLat!),
                                  //       double.parse(widget.trip.toLong!)),
                                  // ]
                                    ,
                                  color: const Color(0xFF7B61FF),
                                  width: 6,
                                ),}
                                    :

                                /// without trip
                                {



                                  Polyline(
                                    polylineId: const PolylineId("route"),
                                    points:cubit.latLngListTrip
                                    // [
                                    //   LatLng(
                                    //     homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                    //         .currentLocation!.latitude! : 0,
                                    //     homeDriverCubit!.currentLocation != null ? homeDriverCubit!
                                    //         .currentLocation!.longitude! : 0,
                                    //   ),
                                    //   LatLng(double.parse(widget.trip.fromLat!),
                                    //       double.parse(widget.trip.fromLong!)),
                                    // ]
                                    ,
                                    color: const Color(0xFF7B61FF),
                                    width: 6,
                                  ),},
                              onCameraMove: (position) {

                                if (homeDriverCubit.strartlocation != position.target) {
                                  // print(cubit.strartlocation);
                                  homeDriverCubit.strartlocation = position.target;
                                  homeDriverCubit.getCurrentLocation();

                                  if( widget.trip.toAddress != null ){
                                   if( cubit.tripStages ==2 )
                                    cubit.getDirection(
                                        LatLng(homeDriverCubit.currentLocation!.latitude!, homeDriverCubit.currentLocation!.longitude!),
                                        LatLng(double.parse(widget.trip.toLat??"0"), double.parse(widget.trip.toLong??"0")));

                                        else
                                    cubit.getDirection(
                                        LatLng(homeDriverCubit.currentLocation!.latitude!, homeDriverCubit.currentLocation!.longitude!),
                                        LatLng(double.parse(widget.trip.fromLat??"0"), double.parse(widget.trip.fromLong??"0")));
                                  }
                                  else{

                                    if (cubit.tripStages ==0){
                                      cubit.getDirection(
                                          LatLng(homeDriverCubit.currentLocation!.latitude!, homeDriverCubit.currentLocation!.longitude!),
                                          LatLng(double.parse(widget.trip.fromLat??"0"), double.parse(widget.trip.fromLong??"0")));
                                    }
                                  }

                                }



                              //  if (homeDriverCubit.strartlocation!=position.target){
                              //    print(homeDriverCubit.strartlocation);
                              //    homeDriverCubit.strartlocation=position.target;
                              //    homeDriverCubit.getCurrentLocation();}
                                // _customInfoWindowController.hideInfoWindow!();
                              },


                            );
                          }
                        ),
                        // child: GoogleMap(
                        //   initialCameraPosition: CameraPosition(
                        //     target: LatLng(
                        //         double.parse(widget.trip.fromLat ?? "31.1234"),
                        //         double.parse(
                        //             widget.trip.fromLong ?? "31.098765")),
                        //     //LatLng(31.1234, 31.098765),
                        //     zoom: 12,
                        //   ),
                        //   markers:
                        //   widget.trip.tripType != 'without' ?
                        //
                        //   {
                        //     Marker(
                        //       markerId: MarkerId("from"),
                        //       position: LatLng(double.parse(widget.trip.fromLat!),
                        //           double.parse(widget.trip.fromLong!)),
                        //     ),
                        //
                        //     Marker(
                        //       markerId: MarkerId("to"),
                        //       position: LatLng(double.parse(widget.trip.toLat!),
                        //           double.parse(widget.trip.toLong!)),
                        //     ),
                        //   }
                        //       :
                        //
                        //       // context.read<TripDetailsCubit>().markers,
                        //       {
                        //     Marker(
                        //       markerId: MarkerId("from"),
                        //       position: LatLng(double.parse(widget.trip.fromLat!),
                        //           double.parse(widget.trip.fromLong!)),
                        //     ),
                        //
                        //   },
                        //
                        //   polylines: widget.trip.tripType != 'without'
                        //       ? {
                        //  //  Polyline(
                        //  //      polylineId: const PolylineId("route"),
                        //  //      points: cubit.latLngList,
                        //  //      color: AppColors.black,
                        //  //      width: 5,visible: true
                        //
                        //  //  ),
                        //
                        //
                        //     Polyline(
                        //     polylineId: const PolylineId("route"),
                        //     points: [
                        //       LatLng(double.parse(widget.trip.fromLat!),
                        //           double.parse(widget.trip.fromLong!)),
                        //       LatLng(double.parse(widget.trip.toLat!),
                        //           double.parse(widget.trip.toLong!)),
                        //     ],
                        //     color: const Color(0xFF7B61FF),
                        //     width: 6,
                        //   ),}
                        //       : {
                        //
                        //         },
                        // ),
                      ),
                      //  SizedBox(height: 10,),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       InkWell(
                      //         onTap: () {
                      //           Navigator.pop(context);
                      //         },
                      //         child: Image.asset(
                      //           ImageAssets.backImage,
                      //           color: AppColors.grey3,
                      //           height: getSize(context) / 15,
                      //           width: getSize(context) / 15,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: getSize(context) * 0.02),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
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
                                  widget.trip.user!.name!,
                                  style: TextStyle(
                                      color: AppColors.black1,
                                      fontSize: getSize(context) * 0.04,
                                      fontWeight: FontWeight.w400),
                                ),
                                Spacer(),
                                if (cubit.tripStages == 1)
                                  InkWell(
                                    onTap: () {
                                      widget.trip.toAddress != null ?
                                      cubit.cancelTrip(
                                         context:
                                          context,
                                          id: widget.trip.id.toString(),
                                      ) :
                                      homeDriverCubit.cancelWithoutDestinationTrip(

                                          context,
                                          widget.trip.id.toString(),
                                      );

                                    },
                                    child: Text(
                                      "cancel".tr(),
                                      style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: getSize(context) * 0.04,
                                          fontWeight: FontWeight.w400),
                                    ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                    maxLines: 1,
                                    "${widget.trip.toAddress??"بدون وجهة"}",
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
                        ),
                      ),
                    ),
                    SizedBox(height: getSize(context) * 0.02),
                    if (cubit.tripStages == 0)
                      // accept button
                      CustomButton(
                        text: 'acceptTrip'.tr(),
                        color: AppColors.primary,
                        onClick: () {
                          cubit.acceptTrip(context, widget.trip.id.toString());
                        },
                        width: getSize(context) * 0.9,
                        height: getSize(context) * 0.14,
                      )
                    else if (cubit.tripStages == 1)
                      // start button
                      CustomButton(
                        text: 'startTrip'.tr(),
                        color: AppColors.primary,
                        onClick: () {
                          cubit.startTrip(context, widget.trip.id.toString());
                        },
                        width: getSize(context) * 0.9,
                        height: getSize(context) * 0.14,
                      )
                    else
                      CustomButton(
                        text: 'endTrip'.tr(),
                        color: AppColors.green1,
                        onClick: () {
                          cubit.endTrip(context, widget.trip.id.toString());
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
