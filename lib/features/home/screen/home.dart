
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/home/screen/home_tab.dart';
import 'package:hero/features/home/screen/without_destination_tab.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/close_widget.dart';
import '../../about_hero/screens/about_hero_screen.dart';
import '../../edit_profile/screens/edit_profile_screen.dart';
import '../../favourite_locations/screens/favourite_locations_screen.dart';
import '../../hero_trip_policy/screens/hero_trip_policy_screen.dart';
import '../../my_rewards/screens/my_rewards_screen.dart';
import '../../notification/screens/notification_screen.dart';
import '../../safety_rules/screens/safety_rules_screen.dart';
import '../../trip_service/screens/trip_insurance_service_screen.dart';
import '../components/drawer_list_item.dart';
import '../cubit/home_cubit.dart';
import 'add_trip_tab.dart';

class Home extends StatefulWidget {
  // int page = 0;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().tabsController =
        TabController(length: 11, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: context.read<HomeCubit>().tabsController,
              children: [
                HomeTab(),
                AddTripTab(),
               // TripWithoutDestination(),
                NotificationScreen(),
                FavouriteLocationsScreen(),
                EditProfileScreen(),
                TripInsuranceService(),
                MyRewardsScreen(),
                AboutHeroScreen(),
                SafetyRulesScreen(),
                HeroTripPolicyScreen(),
              ],
            ),
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
        child: Column(
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
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //notification screen
                          if (index == 2) {

                            context.read<HomeCubit>().tabsController.animateTo(2);
                            Navigator.pop(context);

                          }
                          else if(index == 3){
                            context.read<HomeCubit>().tabsController.animateTo(3);
                            Navigator.pop(context);
                          }
                          else if(index == 9){
                            context.read<HomeCubit>().tabsController.animateTo(4);
                            Navigator.pop(context);
                          }
                          else if(index == 0){
                            context.read<HomeCubit>().tabsController.animateTo(5);
                            Navigator.pop(context);
                          }
                          else if(index == 1){
                            context.read<HomeCubit>().tabsController.animateTo(6);
                            Navigator.pop(context);
                          }
                          else if(index == 4){
                            context.read<HomeCubit>().tabsController.animateTo(7);
                            Navigator.pop(context);
                          }
                          else if(index == 6){
                            context.read<HomeCubit>().tabsController.animateTo(8);
                            Navigator.pop(context);
                          }
                          else if(index == 7){
                            context.read<HomeCubit>().tabsController.animateTo(9);
                            Navigator.pop(context);
                          }
                        },
                        child: DrawerListItem(
                          drawerItemModel: drawerItems[index],
                          textColor: index != drawerItems.length - 1
                              ? AppColors.black1
                              : AppColors.red,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: drawerItems.length)),
          ],
        ),
      ),
    );
  }
}
