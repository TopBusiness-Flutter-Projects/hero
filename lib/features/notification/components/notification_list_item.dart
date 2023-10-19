import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 5,backgroundColor: Colors.green,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(ImageAssets.notification),
              ),
              Text("عنوان الاشعار", style: TextStyle(
                  color: AppColors.black4,
                  fontWeight: FontWeight.w700,
                  fontSize: getSize(context)*0.05
              ),),
              Spacer(),
              Text("منذ 20 دقيقة", style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: getSize(context)*0.03
              ),),
            ],),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: getSize(context)*0.035),
            child: Text(" تفاصيل الاشعار يتم كتابتها هنا . تفاصيل الاشعار تفاصيل الاشعار.",
              maxLines: 2,
              style: TextStyle(
                  color: AppColors.black4,
                  fontWeight: FontWeight.w400,
                  fontSize: getSize(context)*0.04
              ),
              overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    );
  }
}
