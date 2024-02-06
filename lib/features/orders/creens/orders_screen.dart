import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../home/components/home_list_item.dart';
import '../../notification/cubit/cubit/orders_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<OrdersCubit>().tabController = TabController(
        initialIndex: 0,
        // length: widget.allCategoriesModel!.count! + 1, vsync: this);
        length: 3,
        vsync: this);
    context.read<OrdersCubit>().getAllTrips("new");
    context.read<OrdersCubit>().getAllTrips("reject");
    context.read<OrdersCubit>().getAllTrips("complete");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        OrdersCubit cubit = context.read<OrdersCubit>();
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                //welcome mohammed
                BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) =>
                 Row(
                    children: [
                      InkWell(
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
                      Text(
                        'welcome'.tr() +
                            "${context.read<HomeCubit>().signUpModel?.data?.name}",
                        style: TextStyle(
                            fontSize: getSize(context) / 24,
                            fontWeight: FontWeight.normal,
                            color: AppColors.black),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //address + location icon
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 27,
                    ),
                    //address
                    Flexible(
                      child: Text(
                        "${context.read<HomeCubit>().address}",
                        style: TextStyle(
                            fontSize: getSize(context) / 24,
                            fontWeight: FontWeight.normal,
                            color: AppColors.gray),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getSize(context) * 0.03,
                ),
                TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    physics: BouncingScrollPhysics(),
                    //  dividerHeight: 0,
                    // unselectedLabelColor: AppColors.black,
                    controller: cubit.tabController,
                    //  indicatorWeight: 1,
                    indicatorPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    isScrollable: true,
                    onTap: (int value) {
                      if (value == 0) {
                        cubit.getAllTrips("new");
                      }
                      if (value == 1) {
                        cubit.getAllTrips("complete");
                      }
                      if (value == 2) {
                        cubit.getAllTrips("reject");
                      }
                    },
                    tabs: [
                      Text("recent_orders".tr()),
                      Text("completed_orders".tr()),
                      Text("cancelled_orders".tr()),
                    ]),
                SizedBox(
                  height: getSize(context) * 0.03,
                ),
                Flexible(
                  child: TabBarView(
                      // physics: NeverScrollableScrollPhysics(),
                      controller: cubit.tabController,
                      children: [
                        // new orders
                        state is LoadingGettingAllTripsState
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: HomeListItem(
                                        isHome: false,
                                        trip: cubit.newTrips![index]),
                                  );
                                },
                                itemCount: cubit.newTrips?.length ?? 0,
                              ),
                        state is LoadingGettingAllTripsState
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ))
                            :
                            //completed orders
                            ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.tripDetailsRoute,
                                          arguments: cubit.completeTrips![index]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: HomeListItem(
                                        isHome: false,
                                        trip: cubit.completeTrips![index],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: cubit.completeTrips?.length ?? 0,
                              ),
                        // rejected orders
                        state is LoadingGettingAllTripsState
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: HomeListItem(
                                        isHome: false,
                                        trip: cubit.rejectedTrips![index]),
                                  );
                                },
                                itemCount: cubit.rejectedTrips?.length ?? 0,
                              ),
                      ]),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
