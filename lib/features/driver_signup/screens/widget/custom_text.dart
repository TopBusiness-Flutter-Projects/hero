import 'package:flutter/material.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/getsize.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getSize(context) / 44),
      child: Text(text,
          style: getMediumStyle()),
    );
  }
}
