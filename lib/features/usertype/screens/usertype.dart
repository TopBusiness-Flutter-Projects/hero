import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/signup/cubit/signup_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';

class ChooseType extends StatefulWidget {
  const ChooseType({super.key});

  @override
  State<ChooseType> createState() => _ChooseTypeState();
}
class _ChooseTypeState extends State<ChooseType> {
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
              Center(
                child: SizedBox(
                  child: Image.asset(
                    ImageAssets.userTypeImage,
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
                  child: Text("welcome_hero".tr(),
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
                  child: Text("you_can_reach".tr(),
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: getSize(context) / 24,
                      )),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      /// height: getSize(context) / 24,
                      ///width: getSize(context),
                      child: Text("toktok_use".tr(),
                          style: TextStyle(
                            color: AppColors.gray3,
                            fontSize: getSize(context) / 24,
                          )),
                    ),
                    SizedBox(
                      /// height: getSize(context) / 24,
                      ///width: getSize(context),
                      child: Text("register".tr(),
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: getSize(context) / 24,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomButton(
                width: getSize(context),
                text: "register_user".tr(),
                borderRadius: getSize(context) / 24,
                color: AppColors.primary,
                onClick: ()  {
                  context.read<SignupCubit>().signUp("user", context, true);
                 //  Navigator.pushNamedAndRemoveUntil(context, Routes.requestlocationScreenRoute, (route) => false,arguments: "client");
                },
              ),
              SizedBox(
                height: getSize(context) / 16,
              ),
              Material(
                elevation: 2,
                shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(getSize(context)/24)),
                side: BorderSide(color: AppColors.primary)),

                // borderRadius: BorderRadius.all(Radius.circular(getSize(context)/22)),
                //   shape: Border.all(
                //     color: AppColors.primary,
                //
                //   ),
                // decoration: BoxDecoration(
                //     border: Border.all(color: AppColors.primary,width: 2),
                //     borderRadius: BorderRadius.all(
                //
                //         Radius.circular(getSize(context) / 24))),
                child: CustomButton(
                  width: getSize(context),
                  text: "register_driver".tr(),
                  color: AppColors.white,
                  textcolor: AppColors.primary,
                  borderRadius: getSize(context) / 24,
                  onClick: ()  {
                    context.read<SignupCubit>().signUp("driver", context, true);


                   // Navigator.pushNamedAndRemoveUntil(context, Routes.requestlocationScreenRoute, (route) => false,arguments: "driver");

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
