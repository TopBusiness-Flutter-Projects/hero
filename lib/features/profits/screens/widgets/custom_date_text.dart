import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../cubit/profits_cubit.dart';

class CustomDateText extends StatelessWidget {
  const CustomDateText({
    super.key, required this.isToday,

  });

  final bool isToday;


  @override
  Widget build(BuildContext context) {
    ProfitsCubit cubit = context.read<ProfitsCubit>();
    return isToday
        ? CustomText(text: cubit.changeDateFormat(
        cubit.todayDate))
        : BlocConsumer<ProfitsCubit, ProfitsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return
                cubit.selected == 1 ?
                ConditionalBuilder(
                  condition: cubit.profitsModelWeek.data != null,
                  fallback: (context) => SizedBox(height: 50),
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      CustomText(
                          text:
                          cubit.changeDateFormat(
                              cubit.profitsModelWeek.data!.from!)
                             ),
                      CustomText(text: '  -  '),
                      CustomText(text: cubit.selected == 1
                          ? cubit.changeDateFormat(
                          cubit.profitsModelWeek.data!.to!)
                          : cubit.changeDateFormat(
                          cubit.toController.text )),
                    ],
                  ),
                )
               : ConditionalBuilder(
                  condition: cubit.profitsModelCustom.data != null,
                  fallback: (context) => SizedBox(height: 50),
                  builder: (context) =>  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CustomText(
                        text: cubit.fromController.text.isEmpty
                            ?

                        cubit.changeDateFormat(
                                cubit.todayDate)
                            : cubit.changeDateFormat(
                                cubit.fromController.text)),
                    CustomText(text: '  -  '),
                    CustomText(text:cubit.toController.text.isEmpty

              ? cubit.changeDateFormat(
                        cubit.todayDate)
                        : cubit.changeDateFormat(
                        cubit.toController.text )),
                  ],
                               ),
               )

              ;
            });
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getBoldStyle(fontSize: 18, color: AppColors.dateColor),
    );
  }
}
