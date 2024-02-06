import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';
import 'package:hero/features/my_wallet/cubit/my_wallet_cubit.dart';
import 'package:hero/features/my_wallet/screens/widget/custom_wallet_container.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  bool isLoading = true;
  bool isEmpty = true;

  // bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MyWalletCubit>().getWallet();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyWalletCubit, MyWalletState>(
      listener: (context, state) {
        if (state is LoadingNotificationState) {
          isLoading = true;
        } else {
          isLoading = false;
          if (state is SuccessGetWalletState) {
            isEmpty = false;
          }
        }
      },
      builder: (context, state) {
        MyWalletCubit cubit = context.read<MyWalletCubit>();
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
                            : isEmpty
                                ? Center(
                                    child: Text(cubit.myWalletModel.message!),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: double.maxFinite,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.1),
                                                blurRadius: 20,
                                                offset: Offset(
                                                    0, 0), // Shadow position
                                              ),
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.1),
                                                blurRadius: 10,
                                                offset: Offset(
                                                    0, 0), // Shadow position
                                              ),
                                            ],
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "wallet".tr(),
                                                      style: getRegularStyle(
                                                          fontSize: 18),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      25,
                                                                  vertical: 10),
                                                          child: Text(
                                                            "pay".tr(),
                                                            style: getRegularStyle(
                                                                fontSize: 18,
                                                                color: AppColors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    MyCustomSvgWidget(
                                                      path:
                                                          ImageAssets.myWallet,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        cubit.myWalletModel
                                                            .data!.vatTotal!,
                                                        style: getBoldStyle(
                                                            fontSize: 30),
                                                      ),
                                                    ),
                                                    Text(
                                                      'currency'.tr(),
                                                      style: getRegularStyle(
                                                          color: AppColors
                                                              .currencyColor,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                      Text(
                                        "latestTransfers".tr(),
                                        style: getBoldStyle(
                                            color: AppColors.gray3),
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return CustomMyWalletWidget(time: cubit.myWalletModel.data!.trips![index].timeArrive!.toString(),
                                            vat: cubit.myWalletModel.data!.trips![index].vat.toString(),);
                                          },
                                          separatorBuilder: (context, index) {
                                            return Divider(
                                              color: AppColors.grey2,
                                              thickness: 1,
                                            );
                                          },
                                          itemCount: cubit.myWalletModel.data!.trips!.length ??
                                              0)
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


