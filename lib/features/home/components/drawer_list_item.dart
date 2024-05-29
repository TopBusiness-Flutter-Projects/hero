import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

import '../../../core/utils/assets_manager.dart';

class DrawerListItem extends StatelessWidget {
  final DrawerItemModel drawerItemModel;
  final Color textColor;
  const DrawerListItem(
      {super.key, required this.drawerItemModel, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: getSize(context) * 0.04,
        ),
        SvgPicture.asset(drawerItemModel.imagePath),
        SizedBox(
          width: getSize(context) * 0.03,
        ),
        Text(
          drawerItemModel.title,
          style: TextStyle(color: textColor),
        ).tr(),
      ],
    );
  }
}

class DrawerItemModel {
  final String imagePath;
  final String title;

  DrawerItemModel({required this.imagePath, required this.title});
}

List<DrawerItemModel> drawerItems = [
  DrawerItemModel(
      imagePath: ImageAssets.trips, title: "trip_insurance_service"),
  DrawerItemModel(imagePath: ImageAssets.notifications, title: "notifications"),
  DrawerItemModel(
      imagePath: ImageAssets.favouriteTitles, title: "favourite_titles"),
  DrawerItemModel(imagePath: ImageAssets.rewards, title: "my_rewards"),
  DrawerItemModel(imagePath: ImageAssets.aboutHero, title: "about_hero"),
  DrawerItemModel(
      imagePath: ImageAssets.technicalSupport, title: "contact_support"),
  DrawerItemModel(imagePath: ImageAssets.safety, title: "safety_rules"),
  DrawerItemModel(imagePath: ImageAssets.policy, title: "hero_trip_policy"),
  DrawerItemModel(imagePath: ImageAssets.evaluation, title: "app_evaluation"),
  DrawerItemModel(imagePath: ImageAssets.edit, title: "edit_account"),
  DrawerItemModel(imagePath: ImageAssets.delete, title: "delete_account"),
  DrawerItemModel(imagePath: ImageAssets.signOut, title: "sign_out"),
];
