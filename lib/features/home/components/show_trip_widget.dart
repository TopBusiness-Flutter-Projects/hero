import 'package:easy_localization/easy_localization.dart ' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/core/models/home_model.dart';
import 'package:hero/features/user_trip/cubit/user_trip_cubit.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../cubit/home_cubit.dart';
import 'dart:async';
class ShowTripWidget extends StatefulWidget {
  const ShowTripWidget({super.key, required this.isWith, required this.trip});
  final bool isWith;
  final NewTrip trip;
  @override
  State<ShowTripWidget> createState() => _ShowTripWidgetState();
}
class _ShowTripWidgetState extends State<ShowTripWidget> {
  @override
  void initState() {
    context.read<HomeCubit>().paymentMoney = 0;
    context.read<HomeCubit>().distance = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
               // height: getSize(context) * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.black.withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: 10,
                          offset: Offset(4, 4))
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
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
                          Expanded(
                            child: Text(
                              // " برج الهيلتون الدور الخامس بجوار حتحوت ",
                              "${widget.trip.fromAddress}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.gray,
                                  fontSize: getSize(context) * 0.04,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ]),
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
                        Row(
                          children: [
                            SizedBox(
                              width: getSize(context) * 0.03,
                            ),
                            Expanded(
                              child: Text(
                                // "معهد الكبد القومى ",
                               widget. trip.toAddress??"بدون وجهة",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.gray,
                                    fontSize: getSize(context) * 0.04,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //payment_method
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text("payment_method").tr(),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("payment_quantity").tr(),
                            ),
                          ],
                        ),
                        //cash

                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: getSize(context)/3,
                              height: getSize(context)/6.5,
                              child: RadioListTile(
                                title: Text("cash").tr(),
                                value: cubit.payment,
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                                tileColor: AppColors.black1,
                                activeColor: AppColors.primary,
                                selected: true,
                                groupValue: cubit.payment,
                                onChanged: (value) {
                                  cubit.changeRadioButton(value);
                                },
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("${widget.trip.price}"),
                            ),
                          ],
                        ),
                        //SizedBox(height: 5,),
if(widget.trip.tripType == "scheduled")
                        CustomButton(
                          borderRadius: 16,
                          text: "cancel".tr(),
                          color: AppColors.red,
                          textcolor: AppColors.white,
                          onClick: () async {
                            cubit.cancelTrip(context,tripId: widget.trip.id);
                          },
                          width: getSize(context) / 3,
                        )
                      ],
                    ),
                  ),
                )),
          )
        // )
            ;
      },
    );
  }
}
