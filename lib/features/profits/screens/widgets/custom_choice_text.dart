import 'package:flutter/cupertino.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/app_fonts.dart';

class CustomChoiceText extends StatelessWidget {
  const CustomChoiceText({
    super.key, required this.text, required this.isSelected, this.onTap,
  });
final String text;
final bool isSelected;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Text(text,style: getMediumStyle(fontSize: 18,color: isSelected ?AppColors.primary:AppColors.black3),));
  }
}