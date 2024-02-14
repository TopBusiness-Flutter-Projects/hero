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


class WaitingDriverWidget extends StatefulWidget {

  const WaitingDriverWidget({super.key});

  @override
  State<WaitingDriverWidget> createState() => _WaitingDriverWidgetState();
}

class _WaitingDriverWidgetState extends State<WaitingDriverWidget> {
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
        if (state is SuccessCheckTripStatusState){
        // if(context.read<HomeCubit>().checkTripStatusModel.data != null){
        //   if (context.read<HomeCubit>().checkTripStatusModel.data!.type == 'accept'){
        //     context.read<HomeCubit>().currentEnumStatus = MyEnum.success;
        //     successGetBar("تم قبول رحلتك من قبل ${context.read<HomeCubit>().checkTripStatusModel.data!.driver!.name!}");
        //   }
        // }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return
          // Visibility(
          // visible: cubit.bottomContainerLoadingState,
          // child:
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getSize(context) * 0.8,
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
                      ImageAssets.search,
                      width: getSize(context) / 4,
                    ),
                    //progress indicator
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10.0),
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(20),
                        value: cubit.progressValue,
                        color: AppColors.primary, //<-- SEE HERE
                        backgroundColor: AppColors.grey1, //<-- SEE HERE
                      ),
                    ),
                    //rich text
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12.0),
                      child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                              text: "search_for_drivers".tr(),
                              style: TextStyle(
                                color: AppColors.black2,
                                fontWeight: FontWeight.w700,
                                fontSize: getSize(context) * 0.04,
                              ),
                              children: [
                                TextSpan(
                                  text: "appreciate_your_patience".tr(),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: getSize(context) * 0.04,
                                  ),
                                )
                              ])),
                    ),
                    //button
                    CustomButton(
                      text: "cancel".tr(),
                      color: AppColors.red,
                      onClick: () {


                       // cubit.tabsController.animateTo(0);
                       // cubit.currentEnumStatus = MyEnum.defaultState;
                        cubit.cancelTrip(context);

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
