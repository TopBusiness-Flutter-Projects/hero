import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';
import '../../../core/utils/assets_manager.dart';
import 'package:hero/features/trip_service/screens/zain_cash.dart';

import 'payment_methods.dart';

class TripInsuranceService extends StatelessWidget {
  const TripInsuranceService({super.key});
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
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: CustomButton(
                width: getSize(context),
                text: "getInsurance".tr(),
                borderRadius: getSize(context) / 24,
                color: AppColors.primary,
                onClick: () {
                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ZainCashScreen(),
                                ));
                 
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => PaymentsScreen(),
                  //     ));
                },
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: getSize(context) * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      InkWell(
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
                      Center(
                        child: Text(
                          "trip_insurance_service".tr(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: getSize(context) * 0.06,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                cubit.isLoadingSettings
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //     "cubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancecubit.settingsModel.data?.tripInsurancev"),
                                Html(
                                    data: cubit
                                        .settingsModel.data?.tripInsurance),
                                SizedBox(
                                  height: 60,
                                )
                              ],
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
