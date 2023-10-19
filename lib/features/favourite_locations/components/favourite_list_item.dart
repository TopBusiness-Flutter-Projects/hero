import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/close_widget.dart';

class FavouriteListItem extends StatelessWidget {
  const FavouriteListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          height: getSize(context)/5,
          decoration: BoxDecoration(
            color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: AppColors.black.withOpacity(0.25),offset:Offset(0,0),spreadRadius: 1,blurRadius: 5 )
          ]
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(ImageAssets.location),
              ),
              Flexible(
                child: Text(" برج الهيلتون الدور الخامس بجوار حتحوت",
                  maxLines: 2,
                  style: TextStyle(
                      color: AppColors.black4,
                      fontWeight: FontWeight.w400,
                      fontSize: getSize(context)*0.04
                  ),
                  overflow: TextOverflow.ellipsis,),
              ),
            ],),
    ),
          Positioned(
            left: getSize(context)*0.025,
              top: getSize(context)*0.025,
              child:CloseWidget() ,
          )
        ],
      );
  }
}
