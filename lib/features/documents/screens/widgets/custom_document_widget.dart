import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/getsize.dart';

class CustomDocumentWidget extends StatelessWidget {
  const CustomDocumentWidget({
    super.key, this.img, required this.text,
  });
final File? img;
final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child:img != null ?
          Image.file(img!,
            height: getSize(context) / 2.5,
            width: getSize(context) / 2.5,
            fit: BoxFit.contain,
          )    :

          Image.asset(

            ImageAssets.uploadImage,
            height: getSize(context) / 2.5,
            width: getSize(context) / 2.5,
            fit: BoxFit.contain,
            // height: getSize(context) / 1.2,
            // width: getSize(context) / 1.2,
          ),
        ),
        Center(
          child: SizedBox(
            /// height: getSize(context) / 24,
            ///width: getSize(context),
            child: Text(text,
                style: TextStyle(
                  color: AppColors.gray3,
                  fontSize: getSize(context) / 24,
                )),
          ),
        ),
      ],
    );
  }
}
