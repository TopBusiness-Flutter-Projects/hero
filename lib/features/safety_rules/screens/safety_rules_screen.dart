import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/assets_manager.dart';

class SafetyRulesScreen extends StatelessWidget {
  const SafetyRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: getSize(context) * 0.2,
                      ),
                      Center(
                        child: Text(
                          "safety_rules".tr(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: getSize(context) * 0.06,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: getSize(context) * 0.1,
                      ),
                      cubit.isLoadingSettings
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Wrap(
                                children: [
                                  Html(
                                      data: cubit
                                          .settingsModel?.data?.safetyRoles)
                                  //  Text("${cubit.settingsModel?.data?.safetyRoles}").tr()
                                ],
                              ),
                            )
                    ],
                  ),
                ),
                //back button
                Positioned(
                  top: getSize(context) * 0.01,
                  right: getSize(context) * 0.02,
                  //  left: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12),
                      child: Image.asset(
                        ImageAssets.backImage,
                        color: AppColors.grey3,
                        height: getSize(context) / 15,
                        width: getSize(context) / 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
