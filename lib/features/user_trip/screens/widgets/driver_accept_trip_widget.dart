import 'package:easy_localization/easy_localization.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/config/routes/app_routes.dart';
import 'package:hero/features/user_trip/cubit/user_trip_cubit.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/getsize.dart';

import 'dart:async';

import '../../../home/cubit/home_cubit.dart';

class DriverAcceptWidget extends StatefulWidget {
  const DriverAcceptWidget({super.key});

  @override
  State<DriverAcceptWidget> createState() => _DriverAcceptWidgetState();
}

class _DriverAcceptWidgetState extends State<DriverAcceptWidget> {
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
           if (context.read<HomeCubit>().checkTripStatusModel.data!.type == 'progress'){
             //  context.read<HomeCubit>().currentEnumStatus = MyEnum.success;

             context.read<UserTripCubit>().getDriverStartTripStage();
             successGetBar(context.read<HomeCubit>().checkTripStatusModel.message!);
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
                      width: getSize(context) / 5,
                    ),

                    //rich text
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0),
                        child: Text("confirm_driver".tr())),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
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
                          ),
                        ],),

                        Row(
                          children: [


                            InkWell(
                                onTap: () async{


                                  String url = 'tel:${cubit.checkTripStatusModel.data!.driver!.phone!}';

                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Image.asset(ImageAssets.phone,width: 36,height: 36)),SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () async{

                                  String number = cubit.checkTripStatusModel.data!.driver!.phone!;
                                  var whatsappUrl = "whatsapp://send?phone=$number";

                                  var whatsappUrlIos =
                                      "https://api.whatsapp.com/send?phone=$number=";
                                  final _url = Uri.parse(whatsappUrl);
                                  final _urlIos = Uri.parse(whatsappUrlIos);

                                  if (GetPlatform.isIOS) {
                                    launchUrl(
                                      _urlIos,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    launchUrl(
                                      _url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: Image.asset(ImageAssets.whats,width: 36,height: 36)),
                            SizedBox(
                              width: 10,
                            ),
                          ],
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
