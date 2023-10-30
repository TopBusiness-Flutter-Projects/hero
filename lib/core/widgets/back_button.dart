import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/cubit/home_cubit.dart';
import '../utils/app_colors.dart';
import '../utils/assets_manager.dart';
import '../utils/getsize.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        context.read<HomeCubit>().tabsController.animateTo(0);
        context.read<HomeCubit>().latLngList=[];
      },
      child: Image.asset(
        ImageAssets.backImage,
        color: AppColors.grey3,
        height: getSize(context) / 15,
        width: getSize(context) / 15,

      ),
    );
  }
}
