import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/models/home_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem({super.key, this.isHome = true, this.trip});
  final bool isHome;
  final NewTrip? trip;

  @override
  Widget build(BuildContext context) {
    // String formattedDate = formatApiDateTime(trip!.createdAt.toString());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      margin: EdgeInsets.symmetric(
          horizontal: getSize(context) * 0.01,
          vertical: getSize(context) * 0.015),
      // width: getSize(context)*0.4,
      // height: getSize(context)/4,
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.primary, width: 2)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.primary,
              ),
              SizedBox(
                width: getSize(context) * 0.03,
              ),
              Text(
                // "01/10/2023",
                //  formattedDate.substring(0,17),
                trip?.createdAt.toString().substring(0, 10) ?? "",
                style: TextStyle(
                    color: AppColors.black1,
                    fontSize: getSize(context) * 0.04,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: getSize(context) * 0.1,
              ),
              Icon(
                Icons.watch_later_outlined,
                color: AppColors.primary,
              ),
              SizedBox(
                width: getSize(context) * 0.03,
              ),
              Text(
                // "pm ",
                // trip?.createdAt?.day.toString()+ trip?.createdAt.month.toString()+ trip.createdAt.year.toString(),
                //todo =>
                "${trip!.createdAt!.substring(17, 19)} ",
                style: TextStyle(
                    color: AppColors.gray,
                    fontSize: getSize(context) * 0.04,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                // "03:23",
                trip!.createdAt!.substring(10, 17),
                style: TextStyle(
                    color: AppColors.black1,
                    fontSize: getSize(context) * 0.04,
                    fontWeight: FontWeight.w400),
              ),
              // Spacer(),
              // Visibility(
              //   visible: isHome,
              //   child: TextButton(
              //     onPressed: () {},
              //     child: Text(
              //       "cancel".tr(),
              //       style: TextStyle(color: AppColors.red),
              //     ),
              //   ),
              // ),
              // SizedBox(width:3,)
            ],
          ),
          SizedBox(
            height: 5,
          ),
          //from
          Row(
            children: [
              SvgPicture.asset(ImageAssets.fromToIcon),
              SizedBox(
                width: 10,
              ),
              Text(
                "from".tr(),
                style: TextStyle(
                    color: AppColors.black1,
                    fontSize: getSize(context) * 0.04,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Row(children: [
            SizedBox(
              width: getSize(context) * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Dash(
                  direction: Axis.vertical,
                  length: 40,
                  dashLength: 4,
                  dashColor: Colors.black),
            ),
            SizedBox(
              width: 3,
            ),
            Expanded(
              child: Text(
                // " برج الهيلتون الدور الخامس بجوار حتحوت ",
                "${trip?.fromAddress}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColors.gray,
                    fontSize: getSize(context) * 0.04,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ]),
          Row(
            children: [
              SvgPicture.asset(ImageAssets.toIcon),
              SizedBox(
                width: 10,
              ),
              Text(
                "to".tr(),
                style: TextStyle(
                    color: AppColors.black1,
                    fontSize: getSize(context) * 0.04,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              SizedBox(
                width: getSize(context) * 0.03,
              ),
              Expanded(
                child: Text(
                  // "معهد الكبد القومى ",
                  trip?.toAddress ?? "without destination",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.gray,
                      fontSize: getSize(context) * 0.04,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),

          if (trip!.price != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13.0),
              child: Text(
                "أجرة الرحلة " + "${trip?.price ?? "0"} " + 'currency'.tr(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.primary,
                    fontSize: getSize(context) * 0.05,
                    fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }

  String formatApiDateTime(String apiDateTime) {
    // Parse the API date string into a DateTime object
    DateTime dateTime = DateTime.parse(apiDateTime);

    // Format the DateTime object into a user-friendly format
    String formattedDateTime = DateFormat('MMMM d, y hh:mm a').format(dateTime);

    return formattedDateTime;
  }
}
