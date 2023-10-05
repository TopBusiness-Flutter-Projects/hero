import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';

class RequestLocation extends StatefulWidget {
  const RequestLocation({super.key});

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
                  child: Image.asset(
                    ImageAssets.requestlocationImage,
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
                    child: Text("to_join".tr(),
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
                onClick: () {},
              ),

            ],
          ),
        ),
      ),
    );
  }
}
