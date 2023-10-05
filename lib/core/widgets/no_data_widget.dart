import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, required this.onclick, required this.title}) : super(key: key);

  final VoidCallback onclick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.tr(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.secondPrimary,
            ),
          ),
          SizedBox(height: 12, width: MediaQuery.of(context).size.width),
          Icon(Icons.replay_circle_filled_rounded, color: AppColors.primary,size: 35,),
        ],
      ),
    );
  }
}
