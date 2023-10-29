import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
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
    context
        .read<OrdersCubit>()
        .tabController = TabController(
        initialIndex: 0,
        // length: widget.allCategoriesModel!.count! + 1, vsync: this);
        length: 3, vsync: this);
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
        return Scaffold(
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              //welcome mohammed
              Row(

                children: [
                  CustomBackButton(),
                  SizedBox(width: 5,),
                  Icon(
                    CupertinoIcons.person_circle_fill,
                    color: Colors.grey,
                  ),
                  Text(
                    'welcome'.tr() + "محمد",
                    style: TextStyle(
                        fontSize: getSize(context) / 24,
                        fontWeight: FontWeight.normal,
                        color: AppColors.black),
                  ),
                  Spacer(),
                ],
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
                  Text(
                    "برج الهيلتون الدور الخامس بجوار حتحوت",
                    style: TextStyle(
                        fontSize: getSize(context) / 24,
                        fontWeight: FontWeight.normal,
                        color: AppColors.gray),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.black,
                  controller: cubit.tabController,
                  indicatorWeight: 1,
                  indicatorPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  isScrollable: true,
                  tabs: [
                    Text("recent_orders".tr()),
                    Text("completed_orders".tr()),
                    Text("cancelled_orders".tr()),
                  ]
              )
            ],
          ),
        );
      },
    );
  }
}
