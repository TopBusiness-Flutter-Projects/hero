import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/widgets/custom_bottom_sheet_widget.dart';
import 'package:hero/core/widgets/custom_text_form_field.dart';
import 'package:hero/features/homedriver/screen/widgets/end_trip_sheet.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/show_bottom_sheet.dart';
import '../../cubit/home_driver_cubit.dart';

class EnterClientInfo extends StatefulWidget {
  const EnterClientInfo({super.key});

  @override
  State<EnterClientInfo> createState() => _EnterClientInfoState();
}

class _EnterClientInfoState extends State<EnterClientInfo> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    HomeDriverCubit cubit = context.read<HomeDriverCubit>();


    return BlocConsumer<HomeDriverCubit,HomeDriverState>(
      listener: (context, state) {
        if (state is SuccessStartQuickTripState){

          Navigator.pop(context);
          Navigator.pushNamed(
              context, Routes.QuickTripScreen,
              arguments: cubit.startQuickTripModel.data);
         // showMyBottomSheet(EndTripSheet(), context);
        }
      },

      builder: (context,state) {
        return CustomBottomSheetWidget(buttonText: "ride_now".tr(),
          withClosed: true,

          widget:
          Form
            (
            key: formKey,
            child: Column
              (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("enterClientInfo".tr()),
                CustomTextFormField(labelText: "enterName".tr(),
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                  value!.isEmpty
                      ? '' //  ? '${AppStrings.please} ${AppStrings.enterMissed} '
                      : null,

                ),
                CustomTextFormField(labelText: "enterPhone".tr()
                  ,
                  controller:phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                  value!.isEmpty
                      ? '' //  ? '${AppStrings.please} ${AppStrings.enterMissed} '
                      : null,
                ),
              ],),
          )

          ,
          onPressed: () {
            if (formKey.currentState!.validate()) {
            cubit.startQuickTrip(nameController.text,phoneController.text,context);
             //
            } else {
              // errorGetBar(AppStrings.enterMissed);
              print('Form is Not valid');
            }
          },);
      }
    );
  }
}
