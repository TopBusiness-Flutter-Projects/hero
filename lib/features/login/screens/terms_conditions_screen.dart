import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [

          SizedBox(
            height: getSize(context) * 0.2,
          ),
          Center(
            child: Text(
              "terms".tr(),
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: getSize(context) * 0.06,
                  fontWeight: FontWeight.w700),
            ),
          ),
          //back button
          Positioned(
            top: getSize(context) * 0.1,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      ImageAssets.backImage,
                      color: AppColors.grey3,
                      height: getSize(context) / 15,
                      width: getSize(context) / 15,

                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
