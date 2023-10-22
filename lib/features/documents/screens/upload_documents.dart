import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/core/widgets/my_svg_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(getSize(context) / 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(context) / 24,
            ),
            Row(
              children: [
                Image.asset(
                  ImageAssets.backImage,
                  height: getSize(context) / 13,
                  width: getSize(context) / 13,

                  // height: getSize(context) / 1.2,
                  // width: getSize(context) / 1.2,
                ),
                SizedBox(
                  width: getSize(context) / 22,
                ),
                SizedBox(
                  /// height: getSize(context) / 24,
                  ///width: getSize(context),
                  child: Text("toktok_documents".tr(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: getSize(context) / 24,
                      )),
                ),
              ],
            ),
            Flexible(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: getSize(context) / 24,
                  ),
                  Center(
                    child: Image.asset(
                      ImageAssets.uploadImage,
                      height: getSize(context) / 2.5,
                      width: getSize(context) / 2.5,
                      fit: BoxFit.contain,
                      // height: getSize(context) / 1.2,
                      // width: getSize(context) / 1.2,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      /// height: getSize(context) / 24,
                      ///width: getSize(context),
                      child: Text("agency_number".tr(),
                          style: TextStyle(
                            color: AppColors.gray3,
                            fontSize: getSize(context) / 24,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: getSize(context) / 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Image.asset(
                              ImageAssets.uploadImage,
                              height: getSize(context) / 2.5,
                              width: getSize(context) / 2.5,
                              fit: BoxFit.contain,
                              // height: getSize(context) / 1.2,
                              // width: getSize(context) / 1.2,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              /// height: getSize(context) / 24,
                              ///width: getSize(context),
                              child: Text("annual_tuktuk".tr(),
                                  style: TextStyle(
                                    color: AppColors.gray3,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Center(
                            child: Image.asset(
                              ImageAssets.uploadImage,
                              height: getSize(context) / 2.5,
                              width: getSize(context) / 2.5,
                              fit: BoxFit.contain,
                              // height: getSize(context) / 1.2,
                              // width: getSize(context) / 1.2,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              /// height: getSize(context) / 24,
                              ///width: getSize(context),
                              child: Text("id_card".tr(),
                                  style: TextStyle(
                                    color: AppColors.gray3,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(context) / 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Image.asset(
                              ImageAssets.uploadImage,
                              height: getSize(context) / 2.5,
                              width: getSize(context) / 2.5,
                              fit: BoxFit.contain,
                              // height: getSize(context) / 1.2,
                              // width: getSize(context) / 1.2,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              /// height: getSize(context) / 24,
                              ///width: getSize(context),
                              child: Text("residence_card".tr(),
                                  style: TextStyle(
                                    color: AppColors.gray3,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Center(
                            child: Image.asset(
                              ImageAssets.uploadImage,
                              height: getSize(context) / 2.5,
                              width: getSize(context) / 2.5,
                              fit: BoxFit.contain,
                              // height: getSize(context) / 1.2,
                              // width: getSize(context) / 1.2,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              /// height: getSize(context) / 24,
                              ///width: getSize(context),
                              child: Text("tuktuk_photo".tr(),
                                  style: TextStyle(
                                    color: AppColors.gray3,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(context) / 8,
                  ),
                ],
              ),
            )),
            CustomButton(
              width: getSize(context),
              text: "continue".tr(),
              borderRadius: getSize(context) / 24,
              color: AppColors.primary,
              onClick: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.driverwaitScreenRoute, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
