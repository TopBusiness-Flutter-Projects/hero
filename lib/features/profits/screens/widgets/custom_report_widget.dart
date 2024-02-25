import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/widgets/custom_textfield.dart';
import 'package:hero/features/profits/cubit/profits_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/getsize.dart';
import '../../../../core/widgets/custom_button.dart';

class CustomReportWidget extends StatelessWidget {
  const CustomReportWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfitsCubit, ProfitsState>(
      listener: (context, state) {},
      builder: (context, state) {
        ProfitsCubit cubit = context.read<ProfitsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('from'.tr(), style: getBoldStyle(fontSize: 18)),
            ),
            CustomTextField(
              prefixWidget: Icon(
                CupertinoIcons.calendar_today,
                size: 20,
              ),
              title: 'enterDate'.tr(),
              controller: cubit.fromController,
              textInputType: TextInputType.none,
              backgroundColor: AppColors.white,
              //isEnable: false,
              validatorMessage: 'enterDate'.tr(),
              horizontalPadding: 2,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate:cubit.fromController.text.isEmpty? DateTime(2024):DateTime.parse(cubit.fromController.text),
                  firstDate: DateTime(2024),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != cubit.fromSelectedDate) {
                  cubit.fromSelectedDate = picked;
                  cubit.fromController.text =
                      DateFormat('yyyy-MM-dd').format(picked);
                }
              },
              // controller: controller.phoneNumberController,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('to'.tr(), style: getBoldStyle(fontSize: 18)),
            ),
            CustomTextField(
              prefixWidget: Icon(
                CupertinoIcons.calendar_today,
                size: 20,
              ),
              title: 'enterDate'.tr(),
              controller: cubit.toController,
              textInputType: TextInputType.none,
              backgroundColor: AppColors.white,
              //isEnable: false,
              validatorMessage: 'enterDate'.tr(),
              horizontalPadding: 2,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate:cubit.toController.text.isEmpty? DateTime(2024):DateTime.parse(cubit.toController.text),
                  firstDate: DateTime(2024),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != cubit.toSelectedDate) {
                  cubit.toSelectedDate = picked;
                  cubit.toController.text =
                      DateFormat('yyyy-MM-dd').format(picked);
                }
              },
              // controller: controller.phoneNumberController,
            ),
            SizedBox(
              height: getSize(context) / 13,
            ),
            CustomButton(
              width: getSize(context),
              text: "confirm".tr(),
              borderRadius: getSize(context) / 24,
              color: AppColors.primary,
              onClick: () async {
                if (cubit.toSelectedDate.isAfter(cubit.fromSelectedDate)) {
                  cubit.getProfits('custom');

                  print('okkaaaay');
                } else {
                  errorGetBar('errorDate'.tr());
                  // call api
                }

                // if(formKey.currentState!.validate()){
                //
                //   await cubit.editProfile(widget.type,context);
                //
                // }
              },
            ),
            SizedBox(
              height: getSize(context) / 13,
            ),
          ],
        );
      },
    );
  }
}
