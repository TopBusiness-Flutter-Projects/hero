import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/getsize.dart';

class CustomFromToWidget extends StatelessWidget {
  const CustomFromToWidget({
    super.key,
    required this.from,
    required this.to,
    required this.name,
    this.withName = true,
  });

  final String from;
  final String to;
  final String name;
  final bool withName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withName
            ?  Row(
          children: [
            Icon(
                    CupertinoIcons.person_circle_fill,
                    color: Colors.grey,
                    size: 45,
                  )
               ,
            SizedBox(
              width: 5,
            ),
            Text(
              name,
              style: TextStyle(
                  color: AppColors.black1,
                  fontSize: getSize(context) * 0.04,
                  fontWeight: FontWeight.w400),
            )
          ],
        ) : SizedBox(
    width: 5,
    ),

        SizedBox(
          height: 15,
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
              from,
              // " برج الهيلتون الدور الخامس بجوار حتحوت ",

              maxLines: 1,
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
                to,
                //    "معهد الكبد القومى ",

                maxLines: 1,
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
      ],
    );
  }
}
