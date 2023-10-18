import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getSize(context) / 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(context) / 4,
              ),
              Center(
                child: SizedBox(
                  child: Image.asset(
                    ImageAssets.loginImage,
                    height: getSize(context) / 2.5,
                    width: getSize(context) / 2,
                    // height: getSize(context) / 1.2,
                    // width: getSize(context) / 1.2,
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 8,
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("phone".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 20,
              ),
              Container(
                height: getSize(context) / 10,
                padding:
                    EdgeInsets.symmetric(horizontal: getSize(context) / 16),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: Row(
                  children: [
                    Text("+20",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: getSize(context) / 24,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1),
                      child: VerticalDivider(
                        color: AppColors.primary,
                        // height: getSize(context)/10-2,
                        thickness: 1,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: CustomTextField(
                        title: 'phone'.tr(),
                        textInputType: TextInputType.phone,
                        backgroundColor: AppColors.white,
                        validatorMessage: 'phone_msg'.tr(),
                        horizontalPadding: 0,
                        // controller: controller.phoneNumberController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(context) / 20,
              ),
              Row(
                children: [
                  Checkbox(

                    value: true, onChanged: (value) {},
                    checkColor: AppColors.white,
                    //  hoverColor: AppColors.primary,
                    activeColor: AppColors.primary,


                  ),
                  Text(
                    "agreeto".tr(),
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: getSize(context) / 26),
                  ),
                  Text(
                    "terms".tr(),
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: getSize(context) / 26),
                  ),
                  Text(
                    "company".tr(),
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: getSize(context) / 26),
                  ),
                ],
              ),
              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomButton(
                width: getSize(context),
                text: "follow".tr(),
                color: AppColors.primary,
                onClick: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      Routes.verificationScreenRoute, (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
