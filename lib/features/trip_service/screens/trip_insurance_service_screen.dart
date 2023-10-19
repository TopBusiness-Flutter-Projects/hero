import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

class TripInsuranceService extends StatelessWidget {
  const TripInsuranceService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: getSize(context) * 0.2,
          ),
          Text(
            "trip_insurance_service".tr(),
            style: TextStyle(
                color: AppColors.primary,
                fontSize: getSize(context) * 0.06,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: getSize(context) * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              children: [
                Text("خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات "
                    "خدمة تأمين الرحلاتخدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات "
                    "خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات"
                    " خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات"
                    " خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات خدمة تأمين الرحلات")
              ],
            ),
          )
        ],
      ),
    );
  }
}
