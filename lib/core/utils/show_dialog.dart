import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

createProgressDialog(BuildContext context, String msg) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        content: Row(
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              msg,
              style: TextStyle(color: AppColors.black, fontSize: 15.0),
            )
          ],
        ),
      );
    },
  );
}
