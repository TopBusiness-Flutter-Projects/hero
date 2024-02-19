import 'package:easy_localization/easy_localization.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/config/routes/app_routes.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/features/user_trip/cubit/user_trip_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/getsize.dart';

import 'dart:async';

import '../../../home/cubit/home_cubit.dart';

class TripCompletedWidget extends StatefulWidget {
  const TripCompletedWidget({super.key, required this.trip});
final NewTrip trip;
  @override
  State<TripCompletedWidget> createState() => _TripCompletedWidgetState();
}

class _TripCompletedWidgetState extends State<TripCompletedWidget> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return Container(
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
          child: Column(
            children: [
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
                    "${double.parse(widget.trip.price.toStringAsFixed(2))} د.ع",
                    style: TextStyle(fontSize: getSize(context) * 0.04),
                  ),
                ],
              ),
              SizedBox(
                height: getSize(context) * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {

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
                                      context.read<UserTripCubit>().rate = rating;

                                    },
                                  ),
                                  SizedBox(
                                    height: getSize(context) * 0.03,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: context.read<UserTripCubit>().commentController,
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
                                      print(context.read<UserTripCubit>().rate);
                                      print(widget.trip.id!);
                                      print('fffffffffffff');

                                      context.read<UserTripCubit>().rateTrip(context,widget.trip.id.toString(),context.read<UserTripCubit>().rate.toString(),widget.trip.driver!.id.toString(),context.read<UserTripCubit>().commentController.text);

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


                      // cubit.giveRate(tripId: widget.trip.id!,
                      //     toId: widget.trip.user!.id!,
                  //
                      //     description: cubit.commentController.text,context: context);
                      //   Navigator.pop(context);

                    },
                    child: Text(



                      "rate_trip".tr(),
                      style: TextStyle(color: AppColors.green1),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenLight,
                        minimumSize: Size(getSize(context) * 0.3,
                            getSize(context) * 0.1)),
                  ),
                  ElevatedButton(
                    onPressed: () async {

                 Navigator.pushNamedAndRemoveUntil(context, Routes.homeRoute, (route) => false);
                    },
                    child: Text(
                      "goHome".tr(),
                      style: TextStyle(color: AppColors.green1),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenLight,
                        minimumSize: Size(getSize(context) * 0.3,
                            getSize(context) * 0.1)),
                  ),
                ],
              ),

            ],
          ),
        )

          ;
        //  );
      },
    );

  }
}
