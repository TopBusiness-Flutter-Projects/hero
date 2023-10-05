import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              Image.asset(
                ImageAssets.backImage,
                height: getSize(context) / 13,
                width: getSize(context) /13,

                // height: getSize(context) / 1.2,
                // width: getSize(context) / 1.2,
              ),
              SizedBox(
                height: getSize(context) / 24,
              ),
              Center(
                child: SizedBox(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.gray.withOpacity(0.3),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: AppColors.gray,
                          )),
                      Positioned(
                          top: getSize(context)*0.06,
                          right: -5,
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_rounded,color: AppColors.primary,)))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 16,
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("name".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 20,
              ),
              Container(
                height: getSize(context)/10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/16),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: CustomTextField(
                  title: 'name'.tr(),
                  textInputType: TextInputType.text,
                  backgroundColor: AppColors.white,
                  prefixWidget: const Icon(CupertinoIcons.person),
                  validatorMessage: 'name_msg'.tr(),
                  // controller: controller.phoneNumberController,
                ),
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("email".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 20,
              ),
              Container(
                height: getSize(context)/10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/16),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: CustomTextField(
                  title: 'email'.tr(),
                  textInputType: TextInputType.phone,
                  backgroundColor: AppColors.white,
                  prefixWidget: const Icon(CupertinoIcons.mail),
                  validatorMessage: 'email_msg'.tr(),
                  // controller: controller.phoneNumberController,
                ),
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
                height: getSize(context)/10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/16),
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
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: VerticalDivider(
                        color: AppColors.primary,
                        // height: getSize(context)/10-2,
                        thickness: 1,


                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        title: 'phone'.tr(),
                        textInputType: TextInputType.phone,
                        backgroundColor: AppColors.white,
                        prefixWidget: const Icon(CupertinoIcons.phone),
                        validatorMessage: 'phone_msg'.tr(),
                        // controller: controller.phoneNumberController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomButton(
                width: getSize(context),
                text: "register".tr(),
                borderRadius: getSize(context) / 24,
                color: AppColors.primary,
                onClick: () {},
              ),

            ],
          ),
        ),
      ),
    );
  }
}
