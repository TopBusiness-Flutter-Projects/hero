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

class DriverTripScreen extends StatefulWidget {
  const DriverTripScreen({super.key,required this.trip});
  final NewTrip trip ;
  @override
  State<DriverTripScreen> createState() => _DriverTripScreenState();
}

class _DriverTripScreenState extends State<DriverTripScreen> {

  @override
  void initState() {
   context.read<DriverTripCubit>().setMarkerIcon(widget.trip.toAddress??" ", LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065")),
       LatLng(double.parse(widget.trip.toLat??"31.98354"), double.parse(widget.trip.toLong??"31.1234065")));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DriverTripCubit cubit = context.read<DriverTripCubit>();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DriverTripCubit,DriverTripState>(
          listener: (context, state) {
if (state is SuccessEndTripState)
  {

    showDialog(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)),
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
                              context, Routes.homedriverRoute, (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child:
                          SvgPicture.asset(ImageAssets.close),
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
                  itemPadding:
                  EdgeInsets.symmetric(horizontal: 4.0),
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

cubit.rateUser(context,widget.trip.id.toString(),cubit.rate.toString(),widget.trip.user!.id.toString(),cubit.commentController.text);

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
  }},
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
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target:LatLng(double.parse(widget.trip.fromLat??"31.1234"),double.parse(widget.trip.fromLong??"31.098765")),
                              //LatLng(31.1234, 31.098765),
                          zoom: 12,
                        ),
                        markers:
                       // context.read<TripDetailsCubit>().markers,
                           {
                          Marker(markerId: MarkerId("from"),
                              position: LatLng(double.parse(widget.trip.fromLat!),double.parse(widget.trip.fromLong!)),),
                          Marker(markerId: MarkerId("to"),
                            position: LatLng(double.parse(widget.trip.toLat!),double.parse(widget.trip.toLong!)),),
                       }
                       ,
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("route"),
                            points: [
                              LatLng(double.parse(widget.trip.fromLat!), double.parse(widget.trip.fromLong!)),
                              LatLng(double.parse(widget.trip.toLat!),double.parse(widget.trip.toLong!)),
                            ],
                            color: const Color(0xFF7B61FF),
                            width: 6,
                          ),
                        },
                      ),
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
                              )
                              ,
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
                              if(cubit.tripStages ==1)
                              InkWell(
                                onTap: () {


                                  cubit.cancelTrip(context, widget.trip.id.toString());
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
                                  maxLines: 2,

                                  "${widget.trip.toAddress}",
                                  style: TextStyle(
                                    overflow:TextOverflow.ellipsis ,
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
                  if(cubit.tripStages ==0)
                  // accept button
                  CustomButton(
                    text: 'acceptTrip'.tr(),
                    color: AppColors.primary,
                    onClick: () {

                      cubit.acceptTrip(context,widget.trip.id.toString());
                    },
                    width: getSize(context) * 0.9,
                    height: getSize(context) * 0.14,
                  )
                 else if(cubit.tripStages ==1)
                  // start button
                  CustomButton(
                    text: 'startTrip'.tr(),
                    color: AppColors.primary,
                    onClick: () {



                      cubit.startTrip(context,widget.trip.id.toString());
                    },
                    width: getSize(context) * 0.9,
                    height: getSize(context) * 0.14,
                  )
                  else
                    CustomButton(
                      text: 'endTrip'.tr(),
                      color: AppColors.green1,
                      onClick: () {
                        cubit.endTrip(context,widget.trip.id.toString());
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
    );
  }
}
