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


class DriverSignUp extends StatefulWidget {
  const DriverSignUp({super.key});

  @override
  State<DriverSignUp> createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {
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
                width: getSize(context) / 13,

                // height: getSize(context) / 1.2,
                // width: getSize(context) / 1.2,
              ),
              SizedBox(
                height: getSize(context) / 24,
              ),
              Image.asset(
                ImageAssets.driversignupImage,
                height: getSize(context) / 3,
                width: getSize(context) / 1.5
                ,

                // height: getSize(context) / 1.2,
                // width: getSize(context) / 1.2,
              ),
              SizedBox(
                height: getSize(context) / 16,
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("current_governate".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 60,
              ),
              Container(
                height: getSize(context) / 10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: Center(
                  child:DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: AppColors.white
                      ,
                      filled: true,
                      //  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    value: null,
                    hint: Text(
                      "",
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getSize(context) / 24,
                          color: AppColors.primary),
                    ),
                    items: []
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getSize(context) / 24,
                            color: AppColors.primary),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {

                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: IconStyleData(

                      iconSize: 0,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 32,
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("current_state".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 60,
              ),
              Container(
                height: getSize(context) / 10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: Center(
                  child:DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      //  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    value: null,
                    hint: Text(
                      "",
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getSize(context) / 24,
                          color: AppColors.primary),
                    ),
                    items: []
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getSize(context) / 24,
                            color: AppColors.primary),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {

                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: IconStyleData(

                      iconSize: 0,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 32,
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("toktok_type".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 60,
              ),
              Container(
                height: getSize(context) / 10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: Center(
                  child:DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: AppColors.white
                      ,
                      filled: true,
                      //  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    value: null,
                    hint: Text(
                      "",
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getSize(context) / 24,
                          color: AppColors.primary),
                    ),
                    items: []
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getSize(context) / 24,
                            color: AppColors.primary),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {

                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: IconStyleData(

                      iconSize: 0,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 32,
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("toktok_model".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 60,
              ),
              Container(
                height: getSize(context) / 10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: Center(
                  child:DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: AppColors.white
                      ,
                      filled: true,
                      //  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    value: null,
                    hint: Text(
                      "",
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getSize(context) / 24,
                          color: AppColors.primary),
                    ),
                    items: []
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getSize(context) / 24,
                            color: AppColors.primary),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {

                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: IconStyleData(

                      iconSize: 0,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(context) / 32,
              ),
              SizedBox(
                /// height: getSize(context) / 24,
                ///width: getSize(context),
                child: Text("toktok_color".tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getSize(context) / 24,
                    )),
              ),
              SizedBox(
                height: getSize(context) / 60,
              ),
              Container(
                height: getSize(context) / 10,
                padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.gray6),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getSize(context) / 22))),
                child: Center(
                  child:DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      fillColor: AppColors.white
                      ,
                      filled: true,
                      //  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    value: null,
                    hint: Text(
                      "",
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getSize(context) / 24,
                          color: AppColors.primary),
                    ),
                    items: []
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getSize(context) / 24,
                            color: AppColors.primary),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {

                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: IconStyleData(

                      iconSize: 0,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: getSize(context) / 8,
              ),
              CustomButton(
                width: getSize(context),
                text: "continue".tr(),
                borderRadius: getSize(context) / 24,
                color: AppColors.primary,
                onClick: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.uploadDocumentsScreenRoute, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
