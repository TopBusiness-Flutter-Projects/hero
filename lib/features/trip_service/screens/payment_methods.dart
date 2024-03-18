// ignore_for_file: unused_local_variable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/trip_service/cubit/payment_cubit.dart';
import 'package:hero/features/trip_service/screens/zain_cash.dart';

import '../../../core/utils/assets_manager.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {

      },
      builder: (context, state) {
    PaymentCubit cubit = context.read<PaymentCubit>();
        return SafeArea(
          child: Scaffold(
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
                          "choosePayMethod".tr(),
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
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ZainCashScreen(),
                                ));
                          },
                          child: CustomCard(
                              child: Row(
                            children: [
                              Hero(
                                tag: 'zain',
                                child: Image.asset(ImageAssets.zain,
                                    width: 83, height: 76),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("zainCashPay".tr(),
                                          style: getBoldStyle()),
                                      Text("enterPhoneAndPass".tr(),
                                          maxLines: 2,
                                          style: getRegularStyle(
                                              color: AppColors.grey2))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomCard(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Image.asset(ImageAssets.googlePay,
                                  width: 160, height: 30),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("googlePay".tr(),
                                          style: getBoldStyle()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        CustomCard(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Image.asset(ImageAssets.visa,
                                  width: 150, height: 55),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("visa".tr(), style: getBoldStyle())
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
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

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.25),
                blurRadius: 10,
                spreadRadius: 10,
                offset: Offset(4, 4))
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
