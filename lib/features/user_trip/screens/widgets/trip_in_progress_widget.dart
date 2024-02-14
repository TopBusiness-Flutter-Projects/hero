import 'package:easy_localization/easy_localization.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/config/routes/app_routes.dart';
import 'package:hero/features/user_trip/cubit/user_trip_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/getsize.dart';
import 'dart:async';
import '../../../home/cubit/home_cubit.dart';
class TripINProgressWidget extends StatefulWidget {
  const TripINProgressWidget({super.key});
  @override
  State<TripINProgressWidget> createState() => _TripINProgressWidgetState();
}

class _TripINProgressWidgetState extends State<TripINProgressWidget> {
  @override
  void initState() {

    Timer.periodic(Duration(seconds: 10), (timer) {

      //   context.read<HomeCubit>().getTripStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SuccessCheckTripStatusState){
          if(context.read<HomeCubit>().checkTripStatusModel.data != null){
            if (context.read<HomeCubit>().checkTripStatusModel.data!.type == 'complete'){
              //  context.read<HomeCubit>().currentEnumStatus = MyEnum.success;

            //  context.read<UserTripCubit>().getDriverStartTripStage();
             // successGetBar(context.read<HomeCubit>().checkTripStatusModel.message!);
            }
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return
          // Visibility(
          // visible: cubit.bottomContainerSuccessState,
          //
          // child:
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getSize(context) * 0.6,
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
                      ImageAssets.success,
                      width: getSize(context) / 4,
                    ),

                    //rich text
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0),
                        child: Text("driverStartTrip".tr())),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          cubit.checkTripStatusModel.data!.driver!.name!,
                          style: TextStyle(color: AppColors.black3),
                        )
                      ],
                    )
                  ],
                ),
              ));
        //  );
      },
    );

  }
}
