import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/home/screen/home_tab.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/close_widget.dart';
import '../../../core/widgets/network_image.dart';
import '../../about_hero/screens/about_hero_screen.dart';
import '../../edit_profile/screens/edit_profile_screen.dart';
import '../../favourite_locations/screens/favourite_locations_screen.dart';
import '../../hero_trip_policy/screens/hero_trip_policy_screen.dart';
import '../../my_rewards/screens/my_rewards_screen.dart';
import '../../notification/screens/notification_screen.dart';
import '../../orders/creens/orders_screen.dart';
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
    //  context.read<HomeCubit>().getUserTripStatus(context);
    context.read<HomeCubit>().tabsController =
        TabController(length: 11, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                    HomeTab(),
                    NotificationScreen(),
                    FavouriteLocationsScreen(),
                    FavouriteLocationsScreen(),
                    TripInsuranceService(),
                    MyRewardsScreen(),
                    AboutHeroScreen(),
                    SafetyRulesScreen(),
                    HeroTripPolicyScreen(),
                    OrdersScreen(isUser: true),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: //drawer
                      InkWell(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                      context.read<HomeCubit>().getNotificationCount();
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
                        "${context.read<HomeCubit>().signUpModel?.data?.name}",
                        style: TextStyle(
                            fontSize: getSize(context) * 0.03,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black2),
                      ),
                      // CloseWidget(
                      //   onTap: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                    ],
                  ),
                  leading:
                      context.read<HomeCubit>().signUpModel?.data?.image == null
                          ? CircleAvatar(
                              radius: getSize(context) / 8,
                              backgroundImage: AssetImage(ImageAssets.person),
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(getSize(context) / 8),
                              child: ManageNetworkImage(
                                imageUrl: context
                                    .read<HomeCubit>()
                                    .signUpModel!
                                    .data!
                                    .image!,
                                boxFit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                            ),
                  subtitle: Text(
                    "${context.read<HomeCubit>().signUpModel?.data?.phone}",
                    style: TextStyle(
                        fontSize: getSize(context) * 0.0295,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black2),
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                /// TRIP SERVICE
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.tripInsuranceService);
                              } else if (index == 1) {
                                /// NOTIFICATION
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.notificationRoute);
                              } else if (index == 2) {
                                /// FAVOURITES
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.favoriteRoute);
                              } else if (index == 3) {
                                /// MY REWARDS
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.myRewardsScreen);
                              } else if (index == 4) {
                                /// ABOUT HERO
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.aboutHeroScreen);
                              } else if (index == 5) {
                                /// CALL SUPPORT
                                context
                                    .read<HomeCubit>()
                                    .launchPhoneDialer("+201011827324");
                              } else if (index == 6) {
                                /// SAFETY RULES
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.safetyRulesScreen);
                              } else if (index == 7) {
                                /// HERO POLICY
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.heroTripPolicyScreen);
                              } else if (index == 8) {
                                ///  RATE APP
                                context.read<HomeCubit>().rateApp();
                              } else if (index == 9) {
                                ///EDIT PROFILE
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, Routes.editProfileRoute,
                                    arguments: "user");
                              } else if (index == 10) {
                                /// DELETE ACCOUNT
                                context.read<HomeCubit>().deleteUser(context);
                              } else if (index == 11) {
                                ///LOGOUT
                                context.read<HomeCubit>().logout(context);
                              }
                            },
                            child: index == 0
                                ? Container()
                                : DrawerListItem(
                                    drawerItemModel: drawerItems[index],
                                    textColor: index != drawerItems.length - 1
                                        ? AppColors.black1
                                        : AppColors.red,
                                  ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return index == 0 ? Container() : Divider();
                        },
                        itemCount: drawerItems.length)),
              ],
            ),
          ),
        );
      },
    );
  }
}
