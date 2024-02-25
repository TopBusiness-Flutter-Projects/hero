import 'dart:async';

import 'package:easy_localization/easy_localization.dart ' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/getsize.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../cubit/user_trip_cubit.dart';


class NoDriverWidget extends StatefulWidget {

  const NoDriverWidget({super.key,});

  @override
  State<NoDriverWidget> createState() => _NoDriverWidgetState();
}

class _NoDriverWidgetState extends State<NoDriverWidget> {
  @override
  void initState() {

    Timer.periodic(Duration(seconds: 10), (timer) {
      // context.read<HomeCubit>().getTripStatus();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return

          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getSize(context) * 0.55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      ImageAssets.failure,
                      width: getSize(context) / 4,
                    ),

                    //rich text
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0),
                        child: Text("no_drivers".tr())),
                    //button
                    CustomButton(
                      text: "try_again".tr(),
                      color: AppColors.red,
                      onClick: () {
                        //cubit.tabsController.animateTo(0);
                        cubit.progressValue=0.0;
                        cubit.timer.cancel();
                        context.read<UserTripCubit>().getWaitingDriverStage();
                        cubit.startTimer(context);
                      },
                      width: getSize(context) * 0.9,
                      borderRadius: 16,
                    )
                  ],
                ),
              ));
        // );
      },
    );
  }
}
