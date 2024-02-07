import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/app_fonts.dart';

class CustomProfitsDetails extends StatelessWidget {
  const CustomProfitsDetails({
    super.key, required this.tripsDistance, required this.kiloPrice, required this.cashPay, required this.theWallet, required this.totalProfits,
  });
final String tripsDistance;
final String kiloPrice;
final String cashPay;
final String theWallet;
final String totalProfits;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomRow(text: "tripsDistance".tr(),value: tripsDistance+" "+"KM"),
          CustomRow(text: "kiloPrice".tr(),value:kiloPrice +" "+"currency".tr()),
          CustomRow(text: "cashPay".tr(),value: cashPay+" "+"currency".tr()),
          CustomRow(text: "theWallet".tr(),value: theWallet+" "+"currency".tr(),color: AppColors.red,),
          Divider(color: AppColors.black,thickness: 1),
          CustomRow(text: "totalProfits".tr(),value: totalProfits+" "+"currency".tr(),color: AppColors.totalProfitsColor,),

        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key, required this.text, required this.value, this.color,
  });
final String text;
final String value;
final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: getBoldStyle(fontSize: 18,color: color??AppColors.black),),
          Text(value,style: getBoldStyle(fontSize: 18,color:color?? AppColors.black),),

        ],
      ),
    );
  }
}

