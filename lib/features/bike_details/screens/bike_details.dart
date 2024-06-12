import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/core/widgets/custom_text_form_field.dart';
import 'package:hero/core/widgets/my_svg_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/bike_details_cubit.dart';
import 'widget/custom_areas_menu.dart';
import 'widget/custom_cities_menu.dart';
import 'widget/custom_text.dart';

class BikeDetails extends StatefulWidget {
  const BikeDetails({super.key, this.isUpdate = false});
  final bool isUpdate;
  @override
  State<BikeDetails> createState() => _BikeDetailsState();
}

class _BikeDetailsState extends State<BikeDetails> {
  var bikeTypeController = TextEditingController();
  var bikeModelController = TextEditingController();
  var bikeColorController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<BikeDetailsCubit>().getCities();
    if (widget.isUpdate == true)
      context.read<BikeDetailsCubit>().getDriverData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BikeDetailsCubit cubit = context.read<BikeDetailsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<BikeDetailsCubit, BikeDetailsStates>(
            listener: (context, state) {
          if (state is SuccessStoreDriverDataState) {
            Navigator.of(context)
                .pushNamed(Routes.uploadDocumentsScreenRoute, arguments: false);
          }
          if (state is SuccessUpdateDriverDataState) {
            Navigator.pop(context);
          }

          if (state is SuccessGEtDriverDataState) {
            bikeTypeController.text =
                cubit.driverDataModel.data!.driverDetails!.bikeType ?? '';
            bikeModelController.text =
                cubit.driverDataModel.data!.driverDetails!.bikeModel ?? '';
            bikeColorController.text =
                cubit.driverDataModel.data!.driverDetails!.bikeColor ?? '';
            cubit.changeCity(cubit.driverDataModel.data!.cityId.toString());
            cubit.changeArea(
                cubit.driverDataModel.data!.driverDetails!.areaId.toString());
          }
        }, builder: (context, state) {
          return ConditionalBuilder(
            condition: cubit.citiesModel.data != null,
            fallback: (context) => const ShowLoadingIndicator(),
            builder: (context) => Padding(
              padding: EdgeInsets.all(getSize(context) / 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getSize(context) / 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        ImageAssets.backImage,
                        height: getSize(context) / 13,
                        width: getSize(context) / 13,

                        // height: getSize(context) / 1.2,
                        // width: getSize(context) / 1.2,
                      ),
                    ),
                    SizedBox(
                      height: getSize(context) / 24,
                    ),
                    Image.asset(
                      ImageAssets.driversignupImage,
                      height: getSize(context) / 3,
                      width: getSize(context) / 1.5,
                    ),
                    CustomText(text: "current_governate".tr()),
                    CustomCitiesMenu(),
                    CustomText(text: "current_state".tr()),
                    CustomAreasMenu(),
                    CustomText(text: "toktok_type".tr()),
                    CustomTextFormField(
                        labelText: "toktok_type".tr(),
                        controller: bikeTypeController,
                        prefixIcon: SizedBox(
                          height: getSize(context) / 7,
                        )),
                    CustomText(text: "toktok_model".tr()),
                    CustomTextFormField(
                        labelText: "toktok_model".tr(),
                        controller: bikeModelController,
                        prefixIcon: SizedBox(
                          height: getSize(context) / 7,
                        )),
                    CustomText(text: "toktok_color".tr()),
                    CustomTextFormField(
                        labelText: "toktok_color".tr(),
                        controller: bikeColorController,
                        prefixIcon: SizedBox(
                          height: getSize(context) / 7,
                        )),
                    SizedBox(
                      height: getSize(context) / 22,
                    ),
                    CustomButton(
                      width: getSize(context),
                      text: widget.isUpdate ? "update".tr() : "continue".tr(),
                      borderRadius: getSize(context) / 24,
                      color: AppColors.primary,
                      onClick: () {
                        if (formKey.currentState!.validate() &&
                            cubit.currentArea != '0') {
                          widget.isUpdate
                              ? cubit.updateDriverDetails(
                                  context: context,
                                  bikeType: bikeTypeController.text,
                                  bikeModel: bikeModelController.text,
                                  bikeColor: bikeColorController.text,
                                )
                              : cubit.storeDriverDetails(
                                  context: context,
                                  bikeType: bikeTypeController.text,
                                  bikeModel: bikeModelController.text,
                                  bikeColor: bikeColorController.text,
                                );
                        } else {
                          errorGetBar(AppStrings.enterFeilds);
                          print('Form is Not valid');
                        }

                        //  Navigator.of(context).pushNamed(
                        //    Routes.uploadDocumentsScreenRoute,
                        //  );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
