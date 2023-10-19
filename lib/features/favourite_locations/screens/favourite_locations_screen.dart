import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../components/favourite_list_item.dart';

class FavouriteLocationsScreen extends StatelessWidget {
  const FavouriteLocationsScreen({super.key});

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
                            height: getSize(context) * 1.8,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return FavouriteListItem();
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 10,);
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
