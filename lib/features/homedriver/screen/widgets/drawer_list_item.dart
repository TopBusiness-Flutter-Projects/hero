import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

import '../../../../core/utils/assets_manager.dart';



class DriverDrawerListItem extends StatelessWidget {
 final DriverDrawerItemModel drawerItemModel;
 final Color textColor ;
 const  DriverDrawerListItem({super.key,required this.drawerItemModel,required this.textColor });

  @override
  Widget build(BuildContext context) {
    return Row(
    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: getSize(context)*0.04,),
        SvgPicture.asset(drawerItemModel.imagePath),
        SizedBox(width: getSize(context)*0.03,),
        Text(drawerItemModel.title,style: TextStyle(
          color:textColor),).tr(),
      ],
    );
  }
}

class DriverDrawerItemModel{
  final String imagePath;
  final String title;

  DriverDrawerItemModel({required this.imagePath,required this.title});
}

List<DriverDrawerItemModel> driverDrawerItems = [
  DriverDrawerItemModel(imagePath:ImageAssets.wallet ,title: "wallet"),
  DriverDrawerItemModel(imagePath:ImageAssets.order ,title: "orders"),
  DriverDrawerItemModel(imagePath:ImageAssets.benfit ,title: "profit"),
  DriverDrawerItemModel(imagePath:ImageAssets.notifications ,title: "notifications"),
  DriverDrawerItemModel(imagePath:ImageAssets.update ,title: "update_tiktok_data"),

  DriverDrawerItemModel(imagePath:ImageAssets.upload ,title: "update_documents"),
  DriverDrawerItemModel(imagePath:ImageAssets.trips ,title: "trip_insurance_service"),

  DriverDrawerItemModel(imagePath:ImageAssets.aboutHero ,title: "about_hero"),
  DriverDrawerItemModel(imagePath:ImageAssets.technicalSupport ,title: "contact_support"),
  DriverDrawerItemModel(imagePath:ImageAssets.safety ,title: "safety_rules"),
  DriverDrawerItemModel(imagePath:ImageAssets.policy ,title: "hero_trip_policy"),
  DriverDrawerItemModel(imagePath:ImageAssets.evaluation ,title: "app_evaluation"),
  DriverDrawerItemModel(imagePath:ImageAssets.edit ,title: "edit_account"),
  DriverDrawerItemModel(imagePath:ImageAssets.delete ,title: "delete_account"),
  DriverDrawerItemModel(imagePath:ImageAssets.signOut ,title: "sign_out"),

];
