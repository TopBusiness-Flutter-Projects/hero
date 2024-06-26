import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';

import '../../../../core/utils/assets_manager.dart';

class DriverDrawerListItem extends StatefulWidget {
  final DriverDrawerItemModel drawerItemModel;
  final Color textColor;
  const DriverDrawerListItem(
      {super.key, required this.drawerItemModel, required this.textColor});

  @override
  State<DriverDrawerListItem> createState() => _DriverDrawerListItemState();
}

class _DriverDrawerListItemState extends State<DriverDrawerListItem> {
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
          if (widget.drawerItemModel.isOrder) ...[
            Spacer(),
            if (cubit.orderAndNotificationCountModel.data != null)
              if (cubit.orderAndNotificationCountModel.data!.tripCount != 0)
                CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      cubit.orderAndNotificationCountModel.data!.tripCount
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

class DriverDrawerItemModel {
  final String imagePath;
  final String title;
  final bool isNotification;
  final bool isOrder;

  DriverDrawerItemModel(
      {required this.imagePath,
      required this.title,
      this.isNotification = false,
      this.isOrder = false});
}

List<DriverDrawerItemModel> driverDrawerItems = [
  DriverDrawerItemModel(imagePath: ImageAssets.wallet, title: "wallet"),
  DriverDrawerItemModel(
      imagePath: ImageAssets.order, title: "orders_driver", isOrder: true),
  DriverDrawerItemModel(
      imagePath: ImageAssets.finishTripMoney, title: "profit"),
  DriverDrawerItemModel(
      imagePath: ImageAssets.notifications,
      title: "notifications",
      isNotification: true),
  DriverDrawerItemModel(
      imagePath: ImageAssets.update, title: "update_tiktok_data"),
  DriverDrawerItemModel(
      imagePath: ImageAssets.upload, title: "update_documents"),
  DriverDrawerItemModel(
      imagePath: ImageAssets.trips2, title: "trip_insurance_service"),
  DriverDrawerItemModel(imagePath: ImageAssets.aboutHero, title: "about_hero"),
  DriverDrawerItemModel(
      imagePath: ImageAssets.technicalSupport, title: "contact_support"),
  DriverDrawerItemModel(imagePath: ImageAssets.safety, title: "safety_rules"),
  DriverDrawerItemModel(
      imagePath: ImageAssets.policy, title: "hero_trip_policy"),
  DriverDrawerItemModel(
      imagePath: ImageAssets.evaluation, title: "app_evaluation"),
  DriverDrawerItemModel(imagePath: ImageAssets.edit, title: "edit_account"),
  DriverDrawerItemModel(imagePath: ImageAssets.delete, title: "delete_account"),
  DriverDrawerItemModel(imagePath: ImageAssets.signOut, title: "sign_out"),
];
