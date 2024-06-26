import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero/features/home/screen/banner.dart';
import 'package:hero/features/home/screen/show_trip.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/custom_button.dart';
import '../../user_trip/cubit/user_trip_cubit.dart';
import '../components/home_list_item.dart';
import '../cubit/home_cubit.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});
  int page = 0;
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isLoading = true;
  bool isInTrip = false;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((event) {
      context.read<HomeCubit>().getHomeData(context);
      context.read<HomeCubit>().getUserTripStatus(context);
    });

    context.read<HomeCubit>().getUserData();
    super.initState();
    context.read<HomeCubit>().getHomeData(context);
    context.read<HomeCubit>().getUserTripStatus(context);
    //context.read<HomeCubit>().carouselController = CarouselController();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LoadingHomeDataState) {
          isLoading = true;
        } else if (state is SuccessGettingHomeData) {
          isLoading = false;
        } else if (state is ErrorGettingHomeDataState) {
          isLoading = false;
        }
//     if (state is SuccessCheckTripStatusState){
//       if(context.read<HomeCubit>().checkTripStatusModel.data != null){
//         if (context.read<HomeCubit>().checkTripStatusModel.data!.type == 'accept' || context.read<HomeCubit>().checkTripStatusModel.data!.type == 'new'||context.read<HomeCubit>().checkTripStatusModel.data!.type == 'progress'){
//
//           isInTrip = true;
//         }
//
//
//
//         if (context.read<HomeCubit>().checkTripStatusModel.data!.type == 'accept'){
//
//
//         //  context.read<HomeCubit>().getLocation(LatLng( double.parse(context.read<HomeCubit>().checkTripStatusModel.data!.toLat!) , double.parse(context.read<HomeCubit>().checkTripStatusModel.data!.toLong!)), "to");
//
//        //  Navigator.pushNamed(
//        //    context, Routes.AddTripTab,arguments: true
//        //  );
//
//
//         //  context.read<HomeCubit>().currentEnumStatus = MyEnum.success;
//         //  successGetBar(context.read<HomeCubit>().checkTripStatusModel.message!);
//         }
//         else if(context.read<HomeCubit>().checkTripStatusModel.data!.type == 'new'){
//         //
//
//        //   Navigator.pushNamed(
//        //     context, Routes.AddTripTab,arguments: true
//        //   );
//        //  context.read<HomeCubit>().currentEnumStatus = MyEnum.load;
// //
//
//         }
//       }
//     }
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return Scaffold(
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, right: 10, left: 10, bottom: 10),
                  child: ListView(children: [
                    SizedBox(height: 10),
                    //welcome user
                    Row(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                context
                                            .read<HomeCubit>()
                                            .signUpModel
                                            ?.data
                                            ?.image ==
                                        null
                                    ? Icon(
                                        CupertinoIcons.person_circle_fill,
                                        color: Colors.grey,
                                      )
                                    : CircleAvatar(
                                        radius: getSize(context) / 17,
                                        backgroundImage: NetworkImage(
                                          context
                                                  .read<HomeCubit>()
                                                  .signUpModel!
                                                  .data
                                                  ?.image ??
                                              '',
                                          // width: getSize(context)*0.1,
                                        )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'welcome'.tr() +
                                        "${cubit.signUpModel?.data?.name ?? ""}",
                                    style: TextStyle(
                                        fontSize: getSize(context) / 24,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.black),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 27,
                                ),
                                Expanded(
                                  child: Text(
                                    "${cubit.address ?? ""}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: getSize(context) / 24,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.gray),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //slider+dots
                    cubit.homeModel?.data?.sliders != null
                        ? BannerWidget(
                            sliderData: cubit.homeModel!.data!.sliders!)
                        : SizedBox(
                            height: 12,
                          ), // new orders     //all
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getAddress(
                                  lat: cubit.currentLocation!.latitude!,
                                  lang: cubit.currentLocation!.longitude!);
                            },
                            child: Text(
                              //1111111111
                              'new_orders'.tr(),
                              style: TextStyle(
                                  fontSize: getSize(context) / 20,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.black),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.OrdersScreen,
                                  arguments: true);
                            },
                            child: Text(
                              'all'.tr(),
                              style: TextStyle(
                                  fontSize: getSize(context) / 24,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(context) * 0.03,
                    ),
                    // list of orders
                    SizedBox(
                      height: getSize(context) * 1.24,
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await cubit.getHomeData(context);
                                  await cubit.getUserTripStatus(context);
                                  print('ffffffffffffffffffff');
                                  print(
                                      cubit.homeModel?.data?.newTrips?.length);
                                },
                                child: ConditionalBuilder(
                                  condition:
                                      cubit.homeModel?.data?.newTrips?.length !=
                                          0,
                                  fallback: (context) => ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Text(" لا يوجد طلبات"),
                                        ),
                                      );
                                    },
                                  ),
                                  builder: (context) => ListView.builder(
                                    itemCount: cubit.homeModel?.data?.newTrips
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            //todo=>
                                            if (cubit.homeModel?.data
                                                    ?.newTrips?[index].type ==
                                                "new") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowTripScreen(
                                                            trip: cubit
                                                                    .homeModel!
                                                                    .data!
                                                                    .newTrips![
                                                                index]),
                                                  ));
                                              //  Navigator.pushNamed(
                                              //      context, Routes.AddTripTab,arguments: true
                                              //      );
                                              // context.read<HomeCubit>().tabsController.animateTo(1);
                                              //  Navigator.pushNamed(context, Routes.homeRoute);
                                            }
                                          },
                                          child: HomeListItem(
                                            trip: cubit.homeModel?.data
                                                ?.newTrips?[index],
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: getSize(context) * 0.25),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: getSize(context) * 0.0009),
            child: CustomButton(
              width: getSize(context) / 3,
              text: 'ask_trip'.tr(),
              color: AppColors.primary,
              onClick: () {
                context.read<UserTripCubit>().getWaitingDriverStage();
                showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: getSize(context) * 0.05,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: getSize(context) * 0.06,
                                ),
                                Text("choose_trip").tr(),
                                Spacer(),
                                //close
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(ImageAssets.close)),
                                SizedBox(
                                  width: getSize(context) * 0.05,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getSize(context) * 0.1,
                            ),
                            CustomButton(
                              text: "request_trip".tr(),
                              color: AppColors.primary,
                              onClick: () {
                                context.read<HomeCubit>().setflag(1);
                                Navigator.pop(context);
                                Navigator.pushNamed(context, Routes.AddTripTab,
                                    arguments: false);
                                //  context.read<HomeCubit>().tabsController.animateTo(1);
                              },
                            ),
                            SizedBox(
                              height: getSize(context) * 0.1,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                context.read<HomeCubit>().setflag(2);
                                Navigator.pushNamed(context, Routes.AddTripTab,
                                    arguments: false);
                                //context.read<HomeCubit>().tabsController.animateTo(1);

                                // context.read<HomeCubit>().setMarkers( Marker(
                                //   markerId: const MarkerId("currentLocation"),
                                //   icon: context.read<HomeCubit>().currentLocationIcon,
                                //
                                //   position: LatLng(context.read<HomeCubit>().currentLocation?.latitude??0,
                                //       context.read<HomeCubit>().currentLocation?.longitude??0),
                                // ), null);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getSize(context) * 0.15,
                                    vertical: 2),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: AppColors.primary),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "ride_without_destination".tr(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: AppColors.primary,
                                      fontSize: getSize(context) / 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),

                            // CustomButton(
                            //   text: "ride_without_destination".tr(),
                            //   textcolor: AppColors.primary,
                            //   color: AppColors.white,
                            //   onClick: () {},
                            // ),
                            SizedBox(
                              height: getSize(context) * 0.1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
