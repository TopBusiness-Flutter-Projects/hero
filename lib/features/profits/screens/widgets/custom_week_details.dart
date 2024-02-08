import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../cubit/profits_cubit.dart';

class CustomWeekDetails extends StatelessWidget {
  const CustomWeekDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfitsCubit, ProfitsState>(
        listener: (context, state) {},
        builder: (context, state) {
          ProfitsCubit cubit = context.read<ProfitsCubit>();
          return ConditionalBuilder(
              condition: cubit.profitsModelWeek.data != null,
              fallback: (context) => Container(
                    child: null,
                  ),
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 20,
                            offset: Offset(0, 0), // Shadow position
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 10,
                            offset: Offset(0, 0), // Shadow position
                          ),
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: CustomContainer(
                                        text:
                                            "${cubit.profitsModelWeek.data!.trips![0].dayName}"
                                                .tr(),
                                        value: cubit.profitsModelWeek.data!
                                            .trips![0].price
                                            .toString())),
                                Flexible(
                                    child: CustomContainer(
                                        text:
                                            "${cubit.profitsModelWeek.data!.trips![1].dayName}"
                                                .tr(),
                                        value: cubit.profitsModelWeek.data!
                                            .trips![1].price
                                            .toString())),
                                Flexible(
                                    child: CustomContainer(
                                        text:
                                            "${cubit.profitsModelWeek.data!.trips![2].dayName}"
                                                .tr(),
                                        value: cubit.profitsModelWeek.data!
                                            .trips![2].price
                                            .toString())),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: CustomContainer(
                                        text:
                                            "${cubit.profitsModelWeek.data!.trips![3].dayName}"
                                                .tr(),
                                        value: cubit.profitsModelWeek.data!
                                            .trips![3].price
                                            .toString())),
                                Flexible(
                                    child: CustomContainer(
                                        text:
                                            "${cubit.profitsModelWeek.data!.trips![4].dayName}"
                                                .tr(),
                                        value: cubit.profitsModelWeek.data!
                                            .trips![4].price
                                            .toString())),
                                Flexible(
                                    child: CustomContainer(
                                        text:
                                            "${cubit.profitsModelWeek.data!.trips![5].dayName}"
                                                .tr(),
                                        value: cubit.profitsModelWeek.data!
                                            .trips![5].price
                                            .toString())),
                              ],
                            ),
                            // GridView.count(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   crossAxisCount: 3,
                            //   mainAxisSpacing: 20,
                            //   crossAxisSpacing: 20,
                            //   children:
                            //   List.generate(cubit.profitsModelWeek.data!.trips!.length-1, (index) {
                            //     return CustomContainer(text: "${cubit.profitsModelWeek.data!.trips![index].dayName}".tr(),value: cubit.profitsModelWeek.data!.trips![index].price.toString());
                            //   }
                            //
                            //     ),
                            //
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: SizedBox(
                                  height: 10,
                                )),
                                Flexible(
                                    child: CustomContainer(
                                        text:
                                            "${cubit.profitsModelWeek.data!.trips![6].dayName}"
                                                .tr(),
                                        value: cubit.profitsModelWeek.data!
                                            .trips![6].price
                                            .toString())),
                                Flexible(
                                    child: SizedBox(
                                  height: 10,
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        });
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        color: AppColors.weekColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: getBoldStyle(fontSize: 14, color: AppColors.black),
              ),
              Center(
                  child: Text(
                "$value " + "currency".tr() + "\n",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: getBoldStyle(
                    fontSize: 14, color: AppColors.weekNumberColor),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
