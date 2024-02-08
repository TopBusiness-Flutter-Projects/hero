import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/features/profits/cubit/profits_cubit.dart';

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
    ProfitsCubit cubit = context.read<ProfitsCubit>();
    return BlocConsumer<ProfitsCubit,ProfitsState>(
      listener: (context, state) {

      },
      builder:  (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: cubit.selected == 0 ?
          ConditionalBuilder(
            condition: cubit.profitsModelDay.data != null,
            fallback: (context) => SizedBox(height: 50),
            builder: (context) =>
                Column(
                  children: [
                    CustomRow(text: "tripsDistance".tr(),value: "${cubit.profitsModelDay.data!.tripsDistance ??0}"+" "+"KM"),
                    CustomRow(text: "kiloPrice".tr(),value:"${cubit.profitsModelDay.data!.kmPrice ??0}"+" "+"currency".tr()),
                    CustomRow(text: "cashPay".tr(),value: "${cubit.profitsModelDay.data!.total ??0}"+" "+"currency".tr()),
                    CustomRow(text: "theWallet".tr(),value: "${cubit.profitsModelDay.data!.vatTotal ??0}"+" "+"currency".tr(),color: AppColors.red,),
                    Divider(color: AppColors.black,thickness: 1),
                    CustomRow(text: "totalProfits".tr(),value: "${cubit.profitsModelDay.data!.netTotal ??0}"+" "+"currency".tr(),color: AppColors.totalProfitsColor,),
                  ],
                ),
          ):
          cubit.selected == 1 ?
          ConditionalBuilder(
            condition: cubit.profitsModelWeek.data != null,
            fallback: (context) => SizedBox(height: 50),
            builder: (context) =>
                Column(
                  children: [
                    CustomRow(text: "tripsDistance".tr(),value: "${cubit.profitsModelWeek.data!.tripsDistance ??0}"+" "+"KM"),
                    CustomRow(text: "kiloPrice".tr(),value:"${cubit.profitsModelWeek.data!.kmPrice ??0}"+" "+"currency".tr()),
                    CustomRow(text: "cashPay".tr(),value: "${cubit.profitsModelWeek.data!.total ??0}"+" "+"currency".tr()),
                    CustomRow(text: "theWallet".tr(),value: "${cubit.profitsModelWeek.data!.vatTotal ??0}"+" "+"currency".tr(),color: AppColors.red,),
                    Divider(color: AppColors.black,thickness: 1),
                    CustomRow(text: "totalProfits".tr(),value: "${cubit.profitsModelWeek.data!.netTotal ??0}"+" "+"currency".tr(),color: AppColors.totalProfitsColor,),

                  ],
                ),
          ):
          ConditionalBuilder(
            condition: cubit.profitsModelCustom.data != null,
            fallback: (context) => SizedBox(height: 50),
            builder: (context) =>
                Column(
              children: [
                CustomRow(text: "tripsDistance".tr(),value: "${cubit.profitsModelCustom.data!.tripsDistance ??0}"+" "+"KM"),
                CustomRow(text: "kiloPrice".tr(),value:"${cubit.profitsModelCustom.data!.kmPrice ??0}"+" "+"currency".tr()),
                CustomRow(text: "cashPay".tr(),value: "${cubit.profitsModelCustom.data!.total ??0}"+" "+"currency".tr()),
                CustomRow(text: "theWallet".tr(),value: "${cubit.profitsModelCustom.data!.vatTotal ??0}"+" "+"currency".tr(),color: AppColors.red,),
                Divider(color: AppColors.black,thickness: 1),
                CustomRow(text: "totalProfits".tr(),value: "${cubit.profitsModelCustom.data!.netTotal ??0}"+" "+"currency".tr(),color: AppColors.totalProfitsColor,),

              ],
            ),
          ),
        );
      }
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

