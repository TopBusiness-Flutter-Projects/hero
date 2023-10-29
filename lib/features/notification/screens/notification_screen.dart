import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../home/cubit/home_cubit.dart';
import '../components/notification_list_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            //welcome user
            Row(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Column(
                  children: [
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


                    SizedBox(
                        height: getSize(context) * 2,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return NotificationListItem();
                            },
                            separatorBuilder: (context, index) {
                              return Divider(color: AppColors.grey2,thickness: 1,);
                            },
                            itemCount: 50))
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
