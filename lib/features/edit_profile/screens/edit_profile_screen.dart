import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/my_svg_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
         padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Column(
                      children: [
                        //welcome mohammed
                        Row(

                          children: [
                            CustomBackButton(),
                            SizedBox(width: 5,),
                            Icon(
                              CupertinoIcons.person_circle_fill,
                              color: Colors.grey,
                            ),
                            Text(
                              'welcome'.tr() + "محمد",
                              style: TextStyle(
                                  fontSize: getSize(context) / 24,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.black),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //address + location icon
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 27,
                            ),
                            //address
                            Text(
                              "برج الهيلتون الدور الخامس بجوار حتحوت",
                              style: TextStyle(
                                  fontSize: getSize(context) / 24,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.gray),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),

                       Stack(
                         children: [
                           CircleAvatar(
                             radius: getSize(context)/7,
                               backgroundColor: AppColors.grey3.withOpacity(0.3),
                               child: Icon(Icons.person,size: getSize(context)/4,color: AppColors.grey1,)),
                           Positioned(
                             bottom: getSize(context)*0.005,
                               right: 0,
                               child: CircleAvatar(
                                   radius: getSize(context)/20,
                                   backgroundColor: AppColors.grey1,
                                   child: Icon(Icons.camera_alt_rounded,size: getSize(context)/14,
                                     color: AppColors.grey3,)), )
                         ],
                       ),
                        Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: getSize(context) / 30),
                              child: Text("name".tr(),
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                          ],
                        ),

                        Container(
                          height: getSize(context)/10,
                          //padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.gray6),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getSize(context) / 22))),
                          child: Center(
                            child: CustomTextField(
                              title: 'محمد محمود',
                              textInputType: TextInputType.text,
                              backgroundColor: AppColors.white,
                              prefixWidget: const Icon(CupertinoIcons.person),
                              validatorMessage: 'name_msg'.tr(),
                              horizontalPadding: 2,
                              // controller: controller.phoneNumberController,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                              child: Text("email".tr(),
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                          ],
                        ),

                        Container(
                          height: getSize(context)/10,
                          //  padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.gray6),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getSize(context) / 22))),
                          child: Center(
                            child: CustomTextField(
                              title: 'info@examble.com',
                              textInputType: TextInputType.emailAddress,
                              backgroundColor: AppColors.white,
                              prefixWidget: const Icon(CupertinoIcons.mail),
                              validatorMessage: 'email_msg'.tr(),
                              horizontalPadding: 2,

                              // controller: controller.phoneNumberController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                          child: SizedBox(

                            child: Row(
                              children: [
                                Text("phone".tr(),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: getSize(context) / 24,
                                    )),
                              ],
                            ),
                          ),
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

                                  validatorMessage: 'phone_msg'.tr(),
                                  horizontalPadding: 2,

                                  // controller: controller.phoneNumberController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                          child: SizedBox(

                            child: Row(
                              children: [
                                Text("birth_date".tr(),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: getSize(context) / 24,
                                    )),
                              ],
                            ),
                          ),
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
                              MySvgWidget(path: ImageAssets.calender, imageColor: AppColors.buttonColor, size: 20),
                           SizedBox(width: 10,),
                              Expanded(
                                child: Text(
                                  "1/1/2008",
                                  style: TextStyle(color: AppColors.gray5,fontSize: getSize(context)/24),
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
                          text: "confirm".tr(),
                          borderRadius: getSize(context) / 24,
                          color: AppColors.primary,
                          onClick: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeRoute, (route) => false);

                          },
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
