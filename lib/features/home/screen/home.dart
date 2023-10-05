import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
body:ListView(
  children: [
    Row(
      children: [
        Expanded(child: Column(
          children: [
          Row(
            children: [
              Icon(CupertinoIcons.person_circle_fill),
              Text('welcome_to_you',
                style: TextStyle(
                  fontSize: getSize(context)/24,
                  fontWeight: FontWeight.normal,
                    color: AppColors.black

                ),),
            ],
          )   ,
            Row(
            children: [
              Icon(Icons.pin_drop_outlined),
              Text("برج الهيلتون الدور الخامس بجوار حتحوت",
                style: TextStyle(
                  fontSize: getSize(context)/24,
                  fontWeight: FontWeight.normal,
                  color: AppColors.black
                ),),
            ],
          )
          ],
        )),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(getSize(context)/16)),
              color: AppColors.white
            ),
            child: Icon(Icons.menu))
      ],
    ),
    Row(
      children: [
        Text('new_orders'.tr(),style:
          TextStyle(
            fontSize: getSize(context)/24,
            fontWeight: FontWeight.normal,
            color: AppColors.black
          ),), 
        Text('all'.tr(),style:
          TextStyle(
            fontSize: getSize(context)/24,
            fontWeight: FontWeight.normal,
            color: AppColors.primary
          ),),
        ListView.builder(itemBuilder: (context, index) {
          
        },)
      ],
    )
  ],
)
    );
  }
}
