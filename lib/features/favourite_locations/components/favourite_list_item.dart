import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';

import '../../../core/models/favourite_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/close_widget.dart';

class FavouriteListItem extends StatelessWidget {
  const FavouriteListItem({super.key,required this.favouriteData});
 final FavouriteData favouriteData;

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Stack(
        children: [
          Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
         // height: getSize(context)/5,
          decoration: BoxDecoration(
            color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: AppColors.black.withOpacity(0.25),offset:Offset(0,0),spreadRadius: 1,blurRadius: 5 )
          ]
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(ImageAssets.location),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15),
                  child: Text("${favouriteData.address}",
                    maxLines: 2,
                    style: TextStyle(
                        color: AppColors.black4,
                        fontWeight: FontWeight.w400,
                        fontSize: getSize(context)*0.04
                    ),
                    overflow: TextOverflow.ellipsis,),
                ),
              ),
            ],),
    ),
          Positioned(
            left: getSize(context)*0.025,
              top: getSize(context)*0.025,
              child:InkWell(
                onTap: () {
                  context.read<HomeCubit>().deleteFavourite(addressId: favouriteData.id!, context: context);
                },
                  child: CloseWidget()) ,
          )
        ],
      );
  },
);
  }
}
