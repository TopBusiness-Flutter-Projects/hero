import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/features/homedriver/screen/pages/home_map_driver/cubit/home_driver_cubit.dart';
import 'package:hero/features/homedriver/screen/pages/home_map_driver/screens/home_map_driver.dart';
import 'package:hero/features/homedriver/screen/pages/home_map_driver/screens/immediate_trip_driver.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/close_widget.dart';
import '../../home/components/drawer_list_item.dart';
import '../components/drawer_list_item.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeDriverCubit>().tabsController =
        TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
                controller: context.read<HomeDriverCubit>().tabsController,
                children: [
              HomeMapDriver(),
                  ImmediateTripDriver()

            ]),
            Positioned(
              top: 10,
              left: 10,
              child: //drawer
              InkWell(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      //  margin: EdgeInsets.only(left: 10, top: 10),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(0.25),
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.all(
                                Radius.circular(getSize(context) / 80)),
                            color: AppColors.white),
                        child: Icon(
                          Icons.menu,
                          size: 20,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child:

        ListView(
          shrinkWrap: true,
          physics:  ClampingScrollPhysics(),
          // padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: getSize(context) * 0.1,
            ),
            ListTile(

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "محمد",
                    style: TextStyle(
                        fontSize: getSize(context) * 0.03,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black2),
                  ),
                  CloseWidget(onTap:  () {
                    Navigator.of(context).pop();
                  },),
                ],
              ),
              leading: CircleAvatar(
                radius: getSize(context) * 0.1,
                backgroundImage: AssetImage(ImageAssets.person),
              ),
              subtitle: Text(
                "info@examble.com",
                style: TextStyle(
                    fontSize: getSize(context) * 0.03,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black2),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
                physics:  ClampingScrollPhysics(),

                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //notification screen

                    },
                    child: DriverDrawerListItem(
                      drawerItemModel: driverDrawerItems[index],
                      textColor: index != driverDrawerItems.length - 1
                          ? AppColors.black1
                          : AppColors.red,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: driverDrawerItems.length),
          ],
        ),
      ),
    );
  }
}
