import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/models/notification_model.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import 'package:readmore/readmore.dart';

class NotificationListItem extends StatefulWidget {
  final NotificationData? notificationData;

  NotificationListItem({super.key, this.notificationData});

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  String since = "";
  @override
  void initState() {
    super.initState();
    calculateDuration();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.notificationData!.title == 'رحلة جديدة') {
          Navigator.pushNamed(context, Routes.OrdersScreen, arguments: false);
        }
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(radius: 5,backgroundColor: Colors.green,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset(ImageAssets.notification),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "${widget.notificationData?.title}",
                    style: TextStyle(
                        color: AppColors.black4,
                        fontWeight: FontWeight.w700,
                        fontSize: getSize(context) * 0.05),
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    "منذ ${since} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: getSize(context) * 0.03,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: getSize(context) / 15,
                    right: getSize(context) / 15,
                    top: getSize(context) / 30),
                child: ReadMoreText(
                  "${widget.notificationData?.description}",
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  
                  lessStyle: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: getSize(context) * 0.04),
                  colorClickableText: Colors.pink,
                  trimCollapsedText: 'قراءة المزيد',
                  trimExpandedText: 'أقل',
                  moreStyle: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: getSize(context) * 0.04),
                )

                //  Text(
                //   "${widget.notificationData?.description}",
                //   //maxLines: 2,
                //   style: TextStyle(
                //       color: AppColors.black4,
                //       fontWeight: FontWeight.w400,
                //       fontSize: getSize(context) * 0.04),
                //   //overflow: TextOverflow.ellipsis,
                // ),
                ),
          ],
        ),
      ),
    );
  }

  calculateDuration() {
    Duration difference =
        DateTime.now().difference(widget.notificationData!.createdAt!);
    since = formatDuration(difference);
  }

  String formatDuration(Duration duration) {
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes} minute(s) ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} hour(s) ago';
    } else {
      return DateFormat('MMMM d, y hh:mm a').format(DateTime.now());
    }
  }
}
