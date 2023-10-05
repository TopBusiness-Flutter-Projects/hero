import 'package:flutter/material.dart';

import 'app_colors.dart';

snackBar(String? message,context, {Color? color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
      message == "loading" ? AppColors.white : color,
      elevation: 0,
      content: message == "loading"
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ],
      )
          : Text(
        message!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: AppColors.white),
      ),
      duration: Duration(milliseconds: message == "loading" ? 1500 : 3000),
    ),
  );
}
