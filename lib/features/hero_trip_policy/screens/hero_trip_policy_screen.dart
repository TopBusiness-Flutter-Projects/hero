import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

class HeroTripPolicyScreen extends StatelessWidget {
  const HeroTripPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: getSize(context) * 0.2,
          ),
          Center(
            child: Text(
              "hero_trip_policy".tr(),
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: getSize(context) * 0.06,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: getSize(context) * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              children: [
                Text("hero_trip_policy").tr()
              ],
            ),
          )
        ],
      ),
    );
  }
}