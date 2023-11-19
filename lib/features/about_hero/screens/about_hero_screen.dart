import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';
import 'package:hero/features/home/screen/home.dart';

class AboutHeroScreen extends StatelessWidget {
  const AboutHeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: getSize(context) * 0.2,
              ),
              Center(
                child: Text(
                  "about_hero".tr(),
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: getSize(context) * 0.06,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: getSize(context) * 0.1,
              ),
              cubit.isLoadingSettings?
              Center(
                child: CircularProgressIndicator(color: AppColors.primary,),)
                  :
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  children: [
                    Html(data: cubit.settingsModel?.data?.about)
                   // Text("${cubit.settingsModel?.data?.about}")
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
