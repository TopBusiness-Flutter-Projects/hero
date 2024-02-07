import 'package:easy_localization/easy_localization.dart%20';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class CustomWeekDetails extends StatelessWidget {
  const CustomWeekDetails({
    super.key, required this.saturdayValue, required this.sundayValue, required this.mondayValue, required this.tuesdayValue, required this.wednesdayValue, required this.thursdayValue, required this.fridayValue,
  });
 final String  saturdayValue;
 final String  sundayValue;
 final String  mondayValue;
 final String  tuesdayValue;
 final String  wednesdayValue;
 final String  thursdayValue;
 final String  fridayValue;
  @override
  Widget build(BuildContext context) {
   // "saturday"
   // "sunday"
   // "monday"
   // "tuesday"
   // "wednesday"
   // "thursday"
   // "friday"
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CustomContainer(text: "saturday".tr(),value: saturdayValue),
            CustomContainer(text: "sunday".tr(),value:   sundayValue),
            CustomContainer(text: "monday".tr(),value:   mondayValue),
          ],
        ), Row(
          children: [
            CustomContainer(text: "tuesday".tr(),value:   tuesdayValue),
            CustomContainer(text: "wednesday".tr(),value: wednesdayValue),
            CustomContainer(text: "thursday".tr(),value:  thursdayValue),
          ],
        ),            CustomContainer(text: "friday".tr(),value: fridayValue),

      ],
    );
  }
}
class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key, required this.text, required this.value,
  });
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.weekColor,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 24),
        child: Column(children: [

          Text(text,style: getBoldStyle(fontSize: 14,color: AppColors.black),),
          Text("$value "+"currency".tr(),style: getBoldStyle(fontSize: 14,color: AppColors.weekNumberColor),),

        ],),
      ),
    );
  }
}