import 'package:flutter/material.dart';

import 'app_colors.dart';

void showMyBottomSheet(Widget widget,BuildContext context){
  showModalBottomSheet(
      context: context,
      builder: (context) => widget,
      isDismissible: false,
      isScrollControlled: true,
      
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20))));
}