import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class CustomDateText extends StatelessWidget {
  const CustomDateText({
    super.key, required this.isToday, required this.from, this.to,
  });
final bool isToday;
final String  from;
final String? to;
  @override
  Widget build(BuildContext context) {
    return
      isToday?
      CustomText(text: from)
          :
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text: from),
          CustomText(text: '  -  '),
          CustomText(text: to!),

        ],
      )
      ;
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
      style: getBoldStyle(
          fontSize: 18,
          color: AppColors.dateColor),
    );
  }
}
