import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/getsize.dart';

class CustomBorderedContainer extends StatelessWidget {
  const CustomBorderedContainer({
    super.key,
    required this.child,  this.isDropDown=false,
  });

  final Widget child;
final bool isDropDown;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding:
      EdgeInsets.symmetric(horizontal: getSize(context) / 32),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray6),
          borderRadius: BorderRadius.all(
              Radius.circular(getSize(context) / 66))),

      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical:isDropDown?5: 18),
        child: DropdownButtonHideUnderline(
          child:child,
        ),
      ),
    );
  }
}
