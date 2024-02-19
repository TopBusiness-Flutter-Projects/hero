import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/models/notification_model.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';

class NotificationListItem extends StatefulWidget {
  final NotificationData? notificationData ;

   NotificationListItem({super.key,this.notificationData});

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
    return Container(
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
                child: Text("${widget.notificationData?.title}", style: TextStyle(
                    color: AppColors.black4,
                    fontWeight: FontWeight.w700,
                    fontSize: getSize(context)*0.05
                ),),
              ),
              Spacer(),
              Expanded(
                child: Text("منذ ${since} ",
                  textAlign: TextAlign.center,
                  style: TextStyle(

                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: getSize(context)*0.03,

                ),),
              ),
            ],),
          Padding(
            padding:  EdgeInsets.only(left: getSize(context)/15,right:  getSize(context)/15,top:  getSize(context)/30),
            child: Text("${widget.notificationData?.description}",
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
  calculateDuration(){
    Duration difference = DateTime.now().difference(widget.notificationData!.createdAt!);
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