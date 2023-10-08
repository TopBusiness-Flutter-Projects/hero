import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';

import '../../../core/utils/assets_manager.dart';

class Home extends StatefulWidget {
  int page = 0;

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  Row(
                    children: [
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
                      Container(
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
                          ))
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
                      Text(
                        "برج الهيلتون الدور الخامس بجوار حتحوت",
                        style: TextStyle(
                            fontSize: getSize(context) / 24,
                            fontWeight: FontWeight.normal,
                            color: AppColors.gray),
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
          Column(
            children: [
              CarouselSlider(
                items: [
                  Image.asset(ImageAssets.requestlocationImage),
                  Image.asset(ImageAssets.userTypeImage),
                  Image.asset(ImageAssets.greyToktok),
                ],
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  //enableInfiniteScroll: false,
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height * 0.18,
                  reverse: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    widget.page = index;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(3, (index) {
                    return index == widget.page
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              height: 12,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.hint,
                              ),
                            ),
                          );
                  })
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'new_orders'.tr(),
                style: TextStyle(
                    fontSize: getSize(context) / 20,
                    fontWeight: FontWeight.normal,
                    color: AppColors.black),
              ),
              Text(
                'all'.tr(),
                style: TextStyle(
                    fontSize: getSize(context) / 24,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(
            height: getSize(context)*1.6,
              child: Container(

                child: ListView.builder(
                  itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    width: getSize(context)*0.4,
                   // height: getSize(context)/4,
                   decoration: BoxDecoration(

                     border: Border.all(color: AppColors.primary,width: 2)
                   ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined,color: AppColors.primary,),
                          SizedBox(width: getSize(context)*0.03,),
                          Text("01/10/2023",style: TextStyle(color: AppColors.black1,
                              fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                         SizedBox(width: getSize(context)*0.1,),
                          Icon(Icons.watch_later_outlined,color: AppColors.primary,),
                          SizedBox(width: getSize(context)*0.03,),
                          Text("pm ",style: TextStyle(color: AppColors.gray,
                              fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                          Text("03:23 ",style: TextStyle(color: AppColors.black1,
                              fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                          Spacer(),
                          TextButton(onPressed: () {
                          }, child: Text("cancel".tr(),style: TextStyle(
                            color: AppColors.red
                          ),),
                          ),
                          SizedBox(width: 10,)

                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(children: [
                      SvgPicture.asset(ImageAssets.fromToIcon),
                        SizedBox(width: 10,),
                        Text("from".tr(),style: TextStyle(color: AppColors.black1,
                            fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                      ],),
                      SizedBox(width: 5,),
                      Row(children: [
                        SizedBox(width: 5,),
                       Text("|" ,style: TextStyle(color: AppColors.black1,
                            fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                      ],),

                      Row(children: [
                        SizedBox(width: 5,),
                        Text("|" ,style: TextStyle(color: AppColors.black1,
                            fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                      ],),

                      Row(children: [
                        SizedBox(width: 5,),
                        Text("|" ,style: TextStyle(color: AppColors.black1,
                            fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                      ],),
                      Row(children: [
                        SvgPicture.asset(ImageAssets.toIcon,color: AppColors.primary,),
                        SizedBox(width: 10,),
                        Text("to".tr(),style: TextStyle(color: AppColors.black1,
                            fontSize: getSize(context)*0.04,fontWeight: FontWeight.w400),),
                      ],),
                    ],
                  ));
                },),
              ))
        ],
      ),
    ));
  }
}
