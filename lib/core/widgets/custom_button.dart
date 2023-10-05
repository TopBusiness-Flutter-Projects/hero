import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.text,
      this.isLoading = false,
      required this.color,
      required this.onClick,
      this.paddingHorizontal = 0,
      this.borderRadius = 8,
      this.width,
      this.height,
      this.textcolor = Colors.white})
      : super(key: key);
  final String text;
  final Color color;
  final Color textcolor;
  bool isLoading;
  final double paddingHorizontal;
  final double? borderRadius;
  double? width;
  double? height;

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,

      ),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: width ?? getSize(context) / 1.5,
          height: height ?? getSize(context) / 8.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(borderRadius!),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    color: AppColors.hint)
              ]),
          child: isLoading
              ? CircularProgressIndicator(
                  color: AppColors.white,
                )
              : Text(
                  text,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: textcolor,
                      fontSize: getSize(context) / 20,
                      fontWeight: FontWeight.w400),
                ),
        ),
      ),
    );
  }
}
