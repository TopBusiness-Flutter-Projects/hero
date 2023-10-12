import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../components/drawer_list_item.dart';

class TripWithoutDestination extends StatelessWidget {
   TripWithoutDestination({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12),
            child: Row(
              children: [
                InkWell(
                  onTap:(){
                    context.read<HomeCubit>().controller.animateTo(0);
                  },

                  child: Image.asset(
                    ImageAssets.backImage,
                    height: getSize(context) / 13,
                    width: getSize(context) /13,

                    // height: getSize(context) / 1.2,
                    // width: getSize(context) / 1.2,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    //todo
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
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
                )
              ],
            ),
          ),
        ],
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
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        ImageAssets.close,
                        width: getSize(context) * 0.04,
                      ))
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
                      return DrawerListItem(
                        drawerItemModel: drawerItems[index],
                        textColor: index != drawerItems.length - 1
                            ? AppColors.black1
                            : AppColors.red,
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
