import 'package:easy_localization/easy_localization.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/cubit/home_cubit.dart';
import '../utils/app_colors.dart';
import '../utils/getsize.dart';
import 'close_widget.dart';
import 'custom_button.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  const CustomBottomSheetWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
   required this.widget,  this.withClosed = false,
  });

  final String buttonText;
  final Widget widget;

  final void Function() onPressed;
  final bool withClosed ;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

             if(withClosed)
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CloseWidget()),
              ),
              widget,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomButton(
                  width: getSize(context) ,
                  text: buttonText,
                  color: AppColors.primary,
                  onClick: onPressed,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
