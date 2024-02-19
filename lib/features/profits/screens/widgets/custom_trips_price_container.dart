import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/app_fonts.dart';

import '../../cubit/profits_cubit.dart';

class CustomTripsPriceContainer extends StatelessWidget {
  const CustomTripsPriceContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfitsCubit cubit = context.read<ProfitsCubit>();
    return BlocConsumer<ProfitsCubit,ProfitsState>(
        listener: (context, state) {

        },
        builder:  (context, state) {
          return cubit.selected == 0 ?

          ConditionalBuilder(
            condition: cubit.profitsModelDay.data != null,
            fallback: (context) => SizedBox(height: 50),
            builder: (context) => CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomColumn(text: "trips".tr(),value: "${cubit.profitsModelDay.data!.tripsCount??0}",isPrice: false,),
                  SizedBox(
                      height: 40,
                      child: VerticalDivider(
                          color: AppColors.black, thickness: 1, width: 1)),
                  CustomColumn(text: "price".tr(),value:
                  "${double.parse(double.parse(cubit.profitsModelDay.data!.totalTripsPrice.toString()).toStringAsFixed(2))}"

                ,isPrice: true,)
                ],
              ),
            ),
          ):cubit.selected ==1 ?

          ConditionalBuilder(
            condition: cubit.profitsModelWeek.data != null,
            fallback: (context) => SizedBox(height: 50),
            builder: (context) => CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomColumn(text: "trips".tr(),value: "${cubit.profitsModelWeek.data!.tripsCount??0}",isPrice: false,),
                  SizedBox(
                      height: 40,
                      child: VerticalDivider(
                          color: AppColors.black, thickness: 1, width: 1)),
                  CustomColumn(text: "price".tr(),value:  "${double.parse(double.parse(cubit.profitsModelWeek.data!.totalTripsPrice.toString()).toStringAsFixed(2))}" ,isPrice: true,)
                ],
              ),
            ),
          )
          :

          ConditionalBuilder(
            condition: cubit.profitsModelCustom.data != null,
            fallback: (context) => SizedBox(height: 50),
            builder: (context) => CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomColumn(text: "trips".tr(),value: "${cubit.profitsModelCustom.data!.tripsCount??0}",isPrice: false,),
                  SizedBox(
                      height: 40,
                      child: VerticalDivider(
                          color: AppColors.black, thickness: 1, width: 1)),
                  CustomColumn(text: "price".tr(),value:  "${double.parse(double.parse(cubit.profitsModelCustom.data!.totalTripsPrice.toString()).toStringAsFixed(2))}" ,isPrice: true,)
                ],
              ),
            ),
          );
      }
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
class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key, required this.child,
  });
final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
    child: Container(
    color: AppColors.primaryOpacity2,
    child: Padding(
    padding: const EdgeInsets.all(14),
    child: child)));
  }
}
