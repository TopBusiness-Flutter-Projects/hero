import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/trip_details/cubit/trip_details_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/back_button.dart';
import '../../../core/widgets/custom_button.dart';
import '../../home/cubit/home_cubit.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key,required this.trip});
  final NewTrip trip ;

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {

  @override
  void initState() {
   context.read<TripDetailsCubit>().setMarkerIcon(widget.trip.toAddress??" ", LatLng(double.parse(widget.trip.fromLat??"31.98354"), double.parse(widget.trip.fromLong??"31.1234065")),
       LatLng(double.parse(widget.trip.toLat??"31.98354"), double.parse(widget.trip.toLong??"31.1234065")));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            SizedBox(height: getSize(context) * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              // width: getSize(context)*0.4,
              // height: getSize(context)/4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, offset: Offset(2, 2), color: Colors.grey)
                  ]
                  // border: Border.all(
                  //     color: AppColors.primary, width: 2),
                  ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.calendar_month_outlined,
                      //       color: AppColors.primary,
                      //     ),
                      //     SizedBox(
                      //       width: getSize(context) * 0.03,
                      //     ),
                      //     Text(
                      //       "01/10/2023",
                      //       style: TextStyle(
                      //           color: AppColors.black1,
                      //           fontSize: getSize(context) * 0.04,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //     SizedBox(
                      //       width: getSize(context) * 0.1,
                      //     ),
                      //     Icon(
                      //       Icons.watch_later_outlined,
                      //       color: AppColors.primary,
                      //     ),
                      //     SizedBox(
                      //       width: getSize(context) * 0.03,
                      //     ),
                      //     Text(
                      //       "pm ",
                      //       style: TextStyle(
                      //           color: AppColors.gray,
                      //           fontSize: getSize(context) * 0.04,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //     Text(
                      //       "03:23 ",
                      //       style: TextStyle(
                      //           color: AppColors.black1,
                      //           fontSize: getSize(context) * 0.04,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //     Spacer(),
                      //
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      //from
                      //from
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "وقت الركوب",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: getSize(context) * 0.04),
                              ),
                              Text(
                                "${widget.trip.timeRide}",
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: getSize(context) * 0.04),
                              )
                            ],
                          ),
                          Container(
                              child: Image.asset(
                            "assets/images/mini_car.png",
                            width: getSize(context) * 0.13,
                          )),
                          Column(
                            children: [
                              Text(
                                "وقت الوصول",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: getSize(context) * 0.04),
                              ),
                              Text(
                                "${widget.trip.timeArrive}",
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: getSize(context) * 0.04),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          Text(
                            "${widget.trip.distance}km",
                            style: TextStyle(fontSize: getSize(context) * 0.04),
                          ),
                          SizedBox(
                            width: getSize(context) * 0.15,
                          ),
                          Image.asset(
                            "assets/images/clock.png",
                            height: getSize(context) * 0.05,
                          ),
                          //  Icon(Icons.watch_later_outlined,),
                          SizedBox(
                            width: getSize(context) * 0.02,
                          ),
                          Text(
                            "${widget.trip.time} min",
                            style: TextStyle(fontSize: getSize(context) * 0.04),
                          ),
                          SizedBox(
                            width: getSize(context) * 0.15,
                          ),
                          Image.asset(
                            "assets/images/money.png",
                            height: getSize(context) * 0.05,
                          ),
                          SizedBox(
                            width: getSize(context) * 0.02,
                          ),
                          Text(
                            "${widget.trip.price} د.ع",
                            style: TextStyle(fontSize: getSize(context) * 0.04),
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
            ),
            SizedBox(height: getSize(context) * 0.02),
            BlocBuilder<TripDetailsCubit, TripDetailsState>(
                 builder: (context, state) {
                   TripDetailsCubit cubit = context.read<TripDetailsCubit>();
                   return CustomButton(
              text: 'rate_trip'.tr(),
              color: AppColors.primary,
              onClick: () {
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
                                      Navigator.pop(context);
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

                               cubit.giveRate(tripId: widget.trip.id!,

                                   toId: widget.trip.driver!.id!,
                                   description: cubit.commentController.text,context: context);
                             // Navigator.pop(context);

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
              },
              width: getSize(context) * 0.9,
              height: getSize(context) * 0.14,
            );
  },
)
          ],
        ),
      ),
    );
  }
}
