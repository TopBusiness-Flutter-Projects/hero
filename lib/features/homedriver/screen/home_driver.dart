import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/features/bike_details/cubit/bike_details_cubit.dart';
import 'package:hero/features/homedriver/screen/pages/home_map_driver/screens/home_map_driver.dart';
import 'package:hero/features/homedriver/screen/pages/home_map_driver/screens/immediate_trip_driver.dart';
import 'package:hero/features/homedriver/screen/widgets/custom_slider.dart';
import 'package:hero/features/homedriver/screen/widgets/drawer_list_item.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/close_widget.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../home/components/drawer_list_item.dart';
import '../../home/cubit/home_cubit.dart';
import '../cubit/home_driver_cubit.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});
  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().getUserData();
    context.read<BikeDetailsCubit>().getCities();
    FirebaseMessaging.onMessage.listen((event) {
      context.read<HomeCubit>().checkDocumentsHome(context);
    });
    Timer.periodic(Duration(minutes: 3), (timer) {
      context.read<HomeDriverCubit>().updateDriverLocation();
    });
    context.read<HomeCubit>().getDriverTripStatus(context);
    context.read<HomeDriverCubit>().tabsController =
        TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    HomeDriverCubit cubit = context.read<HomeDriverCubit>();
    return Scaffold(
      key: _scaffoldKey,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller:
                            context.read<HomeDriverCubit>().tabsController,
                        children: [
                          HomeMapDriver(),
                          ImmediateTripDriver(),
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
                                          color:
                                              AppColors.black.withOpacity(0.25),
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
              BlocConsumer<HomeDriverCubit, HomeDriverState>(
                listener: (context, state) {},
                builder: (context, state) => ConditionalBuilder(
                  condition: cubit.driverDataModel.data != null,
                  fallback: (context) => SizedBox(
                    height: 1,
                  ),
                  builder: (context) => CustomSlider(
                    items:
                        // [
                        //   CustomNetworkImage(
                        //                boxFit: BoxFit.fill,
                        //                imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Test-Logo.svg/1175px-Test-Logo.svg.png?20150906031702",

                        //                errorWidget: Image.asset(
                        //                  ImageAssets.mapIcon,
                        //                  fit: BoxFit.contain,
                        //                ),
                        //                width: double.maxFinite),  CustomNetworkImage(
                        //                boxFit: BoxFit.fill,
                        //                imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Test-Logo.svg/1175px-Test-Logo.svg.png?20150906031702",

                        //                errorWidget: Image.asset(
                        //                  ImageAssets.mapIcon,
                        //                  fit: BoxFit.contain,
                        //                ),
                        //                width: double.maxFinite),
                        // ]

                        cubit.driverDataModel.data!.sliders!
                            .map((e) => GestureDetector(
                                  onTap: () async {
                                    final _url = Uri.parse(e.link!);
                                    await launchUrl(_url,
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: CustomNetworkImage(
                                      boxFit: BoxFit.fill,
                                      imageUrl: e.image!,
                                      errorWidget: Image.asset(
                                        ImageAssets.logoImage,
                                        fit: BoxFit.contain,
                                      ),
                                      width: double.maxFinite),
                                ))
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) => ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
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
                    CloseWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
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
              ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        {
                          if (index == 0) {
                            ///  MY WALLET
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.MyWalletScreen);
                          } else if (index == 1) {
                            /// MY ORDERS
                            Navigator.pop(context);

                            Navigator.of(context).pushNamed(Routes.OrdersScreen,
                                arguments: false);
                          } else if (index == 2) {
                            ///  PROFITS
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.ProfitsScreen);
                          } else if (index == 3) {
                            /// NOTIFICATION
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, Routes.notificationRoute);
                          } else if (index == 4) {
                            context.read<BikeDetailsCubit>().getDriverData();

                            ///  BIKE INFORMATION
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed(
                                Routes.bikeDetailsRoute,
                                arguments: true);
                          } else if (index == 5) {
                            ///  BIKE DOCUMENTS
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed(
                                Routes.uploadDocumentsScreenRoute,
                                arguments: true);
                          } else if (index == 6) {
                            /// TRIP SERVICE
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, Routes.tripInsuranceService);
                          } else if (index == 7) {
                            /// ABOUT HERO
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, Routes.aboutHeroScreen);
                          } else if (index == 8) {
                            /// CALL SUPPORT
                            context
                                .read<HomeCubit>()
                                .launchPhoneDialer("+201011827324");
                          } else if (index == 9) {
                            /// SAFETY RULES
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, Routes.safetyRulesScreen);
                          } else if (index == 10) {
                            /// HERO POLICY
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, Routes.heroTripPolicyScreen);
                          } else if (index == 11) {
                            ///  RATE APP
                            context.read<HomeCubit>().rateApp();
                          } else if (index == 12) {
                            ///EDIT PROFILE
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, Routes.editProfileRoute,
                                arguments: "driver");
                          } else if (index == 13) {
                            /// DELETE ACCOUNT
                            context.read<HomeCubit>().deleteUser(context);
                          } else if (index == 14) {
                            ///LOGOUT
                            context.read<HomeCubit>().logout(context);
                          }
                        }
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
      ),
    );
  }
}
