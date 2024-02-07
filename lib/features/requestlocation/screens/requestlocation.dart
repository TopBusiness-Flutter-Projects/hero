import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/requestlocation/cubit/request_location_cubit.dart';
import 'package:hero/features/signup/cubit/signup_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';

class RequestLocation extends StatefulWidget {
  const RequestLocation({super.key, required this.type});
  final String type;

  @override
  State<RequestLocation> createState() => _RequestLocationState();
}

class _RequestLocationState extends State<RequestLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getSize(context) / 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(context) / 24,
              ),
              InkWell(
                onTap: () {


                  Navigator.pushNamed(context,Routes.usertypeScreenRoute);

                },
                child: Image.asset(
                  ImageAssets.backImage,
                  height: getSize(context) / 13,
                  width: getSize(context) /13,

                  // height: getSize(context) / 1.2,
                  // width: getSize(context) / 1.2,
                ),
              ),
              SizedBox(
                height: getSize(context) / 24,
              ),
              Center(
                child: SizedBox(
                  child: Image.asset(
                   widget.type=="client"? ImageAssets.requestlocationImage:ImageAssets.toktokmobileImage,
                    height: getSize(context) / 1.3,
                    width: getSize(context) / 1.1,
                    fit: BoxFit.fill,
                    // height: getSize(context) / 1.2,
                    // width: getSize(context) / 1.2,
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 16,
              ),
              Center(
                child: SizedBox(
                  /// height: getSize(context) / 24,
                  ///width: getSize(context),
                  child: Text("book_toktok_app".tr(),
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: getSize(context) / 22,
                        fontWeight: FontWeight.bold
                      )),
                ),
              ),
              SizedBox(
                height: getSize(context) / 30,
              ),
              Center(
                child: SizedBox(
                  /// height: getSize(context) / 24,
                  ///width: getSize(context),
                  child: Center(
                    child: Text(
                        widget.type=="client"?"to_join".tr():"please_enable".tr(),
                        textAlign:TextAlign.center,
                        style: TextStyle(

                          color: AppColors.gray3,
                          fontSize: getSize(context) / 24,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomButton(
                width: getSize(context),
                text: "continuation".tr(),
                borderRadius: getSize(context) / 24,
                color: AppColors.primary,
                onClick: () {
                  widget.type=="driver"?
                //  Navigator.of(context).pushNamedAndRemoveUntil(Routes.registerScreenRoute, (route) => false,arguments: widget.type);
                  Navigator.of(context).pushNamed(Routes.bikeDetailsRoute,arguments: false):
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeRoute, (route) => false,arguments: widget.type);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
   // fetchLocation();
    context.read<RequestLocationCubit>().checkAndRequestLocationPermission();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token){
      print("token is $token");
      print("***************************************** token end");
      context.read<SignupCubit>().token = token ;
    });

    context.read<SignupCubit>().deviceType = Platform.isAndroid ? 'Android' : 'iOS';
    super.initState();
  }


}


