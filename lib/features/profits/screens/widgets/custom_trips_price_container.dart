import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/app_fonts.dart';

class CustomTripsPriceContainer extends StatelessWidget {
  const CustomTripsPriceContainer({
    super.key, required this.trips, required this.price,
  });
final String trips;
final String price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
      child: Container(
        color: AppColors.primaryOpacity2,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomColumn(text: "trips".tr(),value: trips,isPrice: false,),
              SizedBox(
                  height: 40,
                  child: VerticalDivider(
                      color: AppColors.black, thickness: 1, width: 1)),
              CustomColumn(text: "price".tr(),value: price,isPrice: true,)
            ],
          ),
        ),


      ),
    );
  }
}

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    super.key, required this.text, required this.value, required this.isPrice,
  });
final String text;
final String value;
final bool isPrice;
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      Text(text,style: getBoldStyle(fontSize: 14,color: AppColors.black),),
      Text(isPrice ?"$value "+"currency".tr():value,style:isPrice?getRegularStyle(fontSize: 14,color: AppColors.numberColor): getBoldStyle(fontSize: 14,color: AppColors.numberColor),),

    ],);
  }
}