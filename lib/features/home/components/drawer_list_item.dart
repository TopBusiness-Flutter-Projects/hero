import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';

import '../../../core/utils/assets_manager.dart';

class DrawerListItem extends StatefulWidget {
  final DrawerItemModel drawerItemModel;
  final Color textColor;
  const DrawerListItem(
      {super.key, required this.drawerItemModel, required this.textColor});

  @override
  State<DrawerListItem> createState() => _DrawerListItemState();
}
class _DrawerListItemState extends State<DrawerListItem> {
  // @override
  // void initState() {
  //   context.read<HomeCubit>().getNotificationCount();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: getSize(context) * 0.04,
          ),
          SvgPicture.asset(widget.drawerItemModel.imagePath),
          SizedBox(
            width: getSize(context) * 0.03,
          ),
          Expanded(
            child: Text(
              widget.drawerItemModel.title,
              style: TextStyle(color: widget.textColor),
            ).tr(),
          ),
          if (widget.drawerItemModel.isNotification) ...[
            Spacer(),
            if (cubit.orderAndNotificationCountModel.data != null)
              if (cubit.orderAndNotificationCountModel.data!
                      .notificationsCount !=
                  0)
                CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      cubit.orderAndNotificationCountModel.data!
                          .notificationsCount
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
            SizedBox(
              width: getSize(context) * 0.03,
            ),
          ],
        ],
      );
    });
  }
}

class DrawerItemModel {
  final String imagePath;
  final String title;
  final bool isNotification;
  DrawerItemModel({
    required this.imagePath,
    required this.title,
    this.isNotification = false,
  });
}

List<DrawerItemModel> drawerItems = [
  DrawerItemModel(
      imagePath: ImageAssets.trips, title: "trip_insurance_service"),
  DrawerItemModel(
      imagePath: ImageAssets.notifications,
      title: "notifications",
      isNotification: true),
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
