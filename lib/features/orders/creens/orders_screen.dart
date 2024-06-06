import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/features/driver_trip/cubit/driver_trip_cubit.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';
import 'package:hero/features/homedriver/cubit/home_driver_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../home/components/home_list_item.dart';
import '../../trip_details/screens/trip_details_screen.dart';
import '../cubit/cubit/orders_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, required this.isUser});

  final bool isUser;

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
    context.read<OrdersCubit>().getAllTrips("new", widget.isUser);
    context.read<OrdersCubit>().getAllTrips("reject", widget.isUser);
    context.read<OrdersCubit>().getAllTrips("complete", widget.isUser);
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
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) => Row(
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
                    BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                      return Flexible(
                        child: Text(
                          "${context.read<HomeCubit>().address ?? context.read<HomeDriverCubit>().fromAddress}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: getSize(context) / 24,
                              fontWeight: FontWeight.normal,
                              color: AppColors.gray),
                        ),
                      );
                    }),
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
                        cubit.getAllTrips("new", widget.isUser);
                      }
                      if (value == 1) {
                        cubit.getAllTrips("complete", widget.isUser);
                      }
                      if (value == 2) {
                        cubit.getAllTrips("reject", widget.isUser);
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
                            : ConditionalBuilder(
                                condition: cubit.newTrips?.length != 0,
                                fallback: (context) =>
                                    Center(child: Text('لا يوجد طلبات حاليا')),
                                builder: (context) => ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return BlocBuilder<HomeDriverCubit,
                                            HomeDriverState>(
                                        builder: (context, state) {
                                      return InkWell(
                                        onTap: () {
                                          if (!widget.isUser) {
                                            if (context
                                                    .read<HomeDriverCubit>()
                                                    .driverDataModel
                                                    .data !=
                                                null) {
                                              context
                                                  .read<DriverTripCubit>()
                                                  .getAcceptStage();
                                              if (context
                                                      .read<HomeDriverCubit>()
                                                      .driverDataModel
                                                      .data!
                                                      .driverStatus ==
                                                  0)
                                                errorGetBar(
                                                    'أنت خارج الخدمة الآن');
                                              else
                                                Navigator.pushNamed(context,
                                                    Routes.DriverTripScreen,
                                                    arguments:
                                                        cubit.newTrips![index]);
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: HomeListItem(
                                              isHome: false,
                                              trip: cubit.newTrips![index]),
                                        ),
                                      );
                                    });
                                  },
                                  itemCount: cubit.newTrips?.length ?? 0,
                                ),
                              ),
                        state is LoadingGettingAllTripsState
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ))
                            :
                            //completed orders
                            ConditionalBuilder(
                                condition: cubit.completeTrips?.length != 0,
                                fallback: (context) =>
                                    Center(child: Text('لا يوجد طلبات')),
                                builder: (context) => ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TripDetailsScreen(
                                                      trip:
                                                          cubit.completeTrips![
                                                              index],
                                                      isUser: widget.isUser),
                                            ));
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
                              ),
                        // rejected orders
                        state is LoadingGettingAllTripsState
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ))
                            : ConditionalBuilder(
                                condition: cubit.rejectedTrips?.length != 0,
                                fallback: (context) =>
                                    Center(child: Text('لا يوجد طلبات ملغية')),
                                builder: (context) => ListView.builder(
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
