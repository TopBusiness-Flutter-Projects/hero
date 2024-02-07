import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';
import 'package:hero/features/my_wallet/cubit/my_wallet_cubit.dart';
import 'package:hero/features/my_wallet/screens/widget/custom_wallet_container.dart';
import 'package:hero/features/profits/screens/widgets/custom_profits_details.dart';
import 'package:hero/features/profits/screens/widgets/custom_week_details.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../cubit/profits_cubit.dart';
import 'widgets/custom_choice_text.dart';
import 'widgets/custom_date_text.dart';
import 'widgets/custom_report_widget.dart';
import 'widgets/custom_trips_price_container.dart';

class ProfitsScreen extends StatefulWidget {
  const ProfitsScreen({super.key});

  @override
  State<ProfitsScreen> createState() => _ProfitsScreenState();
}

class _ProfitsScreenState extends State<ProfitsScreen> {
  // bool isLoading = true;
  // bool isEmpty = true;

  bool isLoading = false;
  bool isEmpty = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  context.read<MyWalletCubit>().getWallet();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfitsCubit, ProfitsState>(
      listener: (context, state) {
        //  if (state is LoadingNotificationState) {
        //    isLoading = true;
        //  } else {
        //    isLoading = false;
        //    if (state is SuccessGetWalletState) {
        //      isEmpty = false;
        //    }
        //  }
      },
      builder: (context, state) {
        ProfitsCubit cubit = context.read<ProfitsCubit>();
        HomeCubit homeCubit = context.read<HomeCubit>();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        //welcome user
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                ImageAssets.backImage,
                                color: AppColors.grey3,
                                height: getSize(context) / 15,
                                width: getSize(context) / 15,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              CupertinoIcons.person_circle_fill,
                              color: Colors.grey,
                            ),
                            BlocBuilder<HomeCubit, HomeState>(
                                builder: (context, state) {
                              return Text(
                                'welcome'.tr() +
                                    "${homeCubit.signUpModel?.data?.name}",
                                style: TextStyle(
                                    fontSize: getSize(context) / 24,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.black),
                              );
                            }),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //address + location icon
                        BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                          return Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 27,
                              ),
                              //address
                              Expanded(
                                child: Text(
                                  "${homeCubit.address}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: getSize(context) / 24,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.gray),
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            :  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: getSize(context) / 12),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CustomChoiceText(
                                                text: "today".tr(),
                                                isSelected: cubit.selected == 0,
                                                onTap: () {
                                                  cubit.todaySelect();
                                                },
                                              ),
                                              CustomChoiceText(
                                                text: "week".tr(),
                                                isSelected: cubit.selected == 1,
                                                onTap: () {
                                                  cubit.weekSelect();
                                                },
                                              ),
                                              CustomChoiceText(
                                                text: "report".tr(),
                                                isSelected: cubit.selected == 2,
                                                onTap: () {
                                                  cubit.reportSelect();
                                                },
                                              ),
                                            ]),
                                      ),
                                      if (cubit.selected == 2)
                                        CustomReportWidget(),
                                      CustomDateText(
                                        isToday: cubit.selected == 0,
                                        from: '4th Oct 2023',
                                        to: '4th Nov 2023',
                                      ),
                                      CustomTripsPriceContainer(
                                        trips: '2',
                                        price: '23',
                                      ),
                                      if (cubit.selected == 1)
                                        CustomWeekDetails(
                                          saturdayValue: '7',
                                          sundayValue: '5',
                                          mondayValue: '4',
                                          tuesdayValue: '0',
                                          wednesdayValue: '8',
                                          thursdayValue: '8',
                                          fridayValue: '9',
                                        ),
                                      CustomProfitsDetails(
                                        tripsDistance: '5',
                                        kiloPrice: '5',
                                        cashPay: '20',
                                        theWallet: '30',
                                        totalProfits: '40',
                                      ),
                                    ],
                                  )
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
