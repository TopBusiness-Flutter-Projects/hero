import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hero/features/homedriver/cubit/home_driver_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../home/cubit/home_cubit.dart';
import '../components/notification_list_item.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().getNotification();
    print("address = " + "${context.read<HomeDriverCubit>().fromAddress}");
    context.read<HomeCubit>().getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LoadingNotificationState) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
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
                            Text(
                              'welcome'.tr() +
                                  "${cubit.signUpModel?.data?.name}",
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
                            Expanded(
                              child: Text(
                                "${cubit.address ?? context.read<HomeDriverCubit>().fromAddress}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: getSize(context) / 24,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.gray),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  await context
                                      .read<HomeCubit>()
                                      .getNotification();
                                },
                                child: SizedBox(
                                    height: getSize(context) * 2,
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return NotificationListItem(
                                            notificationData: cubit
                                                .notificationModel
                                                ?.data?[index],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            color: AppColors.grey2,
                                            thickness: 1,
                                          );
                                        },
                                        itemCount: cubit.notificationModel?.data
                                                ?.length ??
                                            0)),
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
