import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../components/favourite_list_item.dart';

class FavouriteLocationsScreen extends StatefulWidget {
  const FavouriteLocationsScreen({super.key});

  @override
  State<FavouriteLocationsScreen> createState() => _FavouriteLocationsScreenState();
}

class _FavouriteLocationsScreenState extends State<FavouriteLocationsScreen> {

  @override
  void initState() {
    context.read<HomeCubit>().getFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return SafeArea(
          child: Scaffold(
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
                                  InkWell(
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
                                  SizedBox(width: 5,),
                                  Icon(
                                    CupertinoIcons.person_circle_fill,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'welcome'.tr() + "${cubit.homeModel?.data?.user?.name}",

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
                                      "${cubit.address??""}",
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
                              SizedBox(height: 10,),
                              RefreshIndicator(
                                onRefresh: () async {
                                 await cubit.getFavourite();
                                },
                                child: SizedBox(
                                    height: getSize(context) * 1.8,
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return
                                            cubit.favouriteModel?.data==null?
                                                Center(child: CircularProgressIndicator(color: AppColors.primary,),):
                                            FavouriteListItem(favouriteData: cubit.favouriteModel!.data![index],);
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(height: 10,);
                                        },
                                        itemCount: cubit.favouriteModel?.data?.length??0)),
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
