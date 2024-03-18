import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/app_colors.dart';
import 'package:hero/core/utils/app_fonts.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/core/widgets/custom_text_form_field.dart';
import '../cubit/payment_cubit.dart';

class ZainCashScreen extends StatefulWidget {
  const ZainCashScreen({super.key, this.isUpdate = false});
  final bool isUpdate;
  @override
  State<ZainCashScreen> createState() => _ZainCashScreenState();
}

class _ZainCashScreenState extends State<ZainCashScreen> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var codeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PaymentCubit cubit = context.read<PaymentCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
          // if (state is SuccessStoreDriverDataState){
          //    Navigator.of(context).pushNamed(
          //      Routes.uploadDocumentsScreenRoute,arguments: false
          //    );
          // } if (state is SuccessUpdateDriverDataState){
          //    Navigator.pop(context);
          // }

          // if (state is SuccessGEtDriverDataState){
          //   bikeTypeController.text =cubit.driverDataModel.data!.driverDetails!.bikeType??'';
          //   bikeModelController.text =cubit.driverDataModel.data!.driverDetails!.bikeModel??'';
          //   bikeColorController.text =cubit.driverDataModel.data!.driverDetails!.bikeColor??'';
          //   cubit.changeCity(cubit.driverDataModel.data!.cityId.toString());
          //   cubit.changeArea(cubit   .driverDataModel.data!.driverDetails!.areaId.toString()) ;
          // }
        }, builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              await cubit.confirmButton();
              cubit.transactionId = '';
              return true;
            },
            child: Padding(
              padding: EdgeInsets.all(getSize(context) / 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getSize(context) * 0.03,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            cubit.confirmButton();
                            cubit.transactionId = '';
                          },
                          child: Image.asset(
                            ImageAssets.backImage,
                            color: AppColors.grey3,
                            height: getSize(context) / 15,
                            width: getSize(context) / 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12),
                          child: Center(
                            child: Text(
                              "zainCashPay".tr(),
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    SizedBox(
                      height: getSize(context) / 24,
                    ),
                    Center(
                      child: Hero(
                        tag: 'zain',
                        child: Image.asset(
                          ImageAssets.zain,
                          height: getSize(context) / 3,
                          width: getSize(context) / 1.5,
                        ),
                      ),
                    ),
                    if (!cubit.isCompleted) ...[
                      CustomText(text: "phoneNumber".tr()),
                      CustomTextFormField(
                          labelText: "enterPhoneNumber".tr(),
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          prefixIcon: SizedBox(
                            height: getSize(context) / 7,
                            width: getSize(context) / 7,
                            child: Center(
                              child: Text(
                                "+964",
                                style: getBoldStyle(
                                    fontHeight: 1.5, color: AppColors.black),
                              ),
                            ),
                          )),
                      CustomText(text: "password".tr()),
                      CustomTextFormField(
                          labelText: "enterPassword".tr(),
                          controller: passwordController,
                          isPassword: true,
                          prefixIcon: SizedBox(
                            height: getSize(context) / 7,
                          )),
                    ] else ...[
                      CustomText(text: "code".tr()),
                      CustomTextFormField(
                          labelText: "enterCode".tr(),
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          prefixIcon: SizedBox(
                            height: getSize(context) / 7,
                          )),
                    ],
                    SizedBox(
                      height: getSize(context) / 22,
                    ),
                    CustomButton(
                      width: getSize(context),
                      text: cubit.isCompleted ? "ادفع" : "confirm".tr(),
                      borderRadius: getSize(context) / 24,
                      color: AppColors.primary,
                      onClick: () {
                        if (cubit.isCompleted) {
                          if (codeController.text.isNotEmpty) {
                            cubit.paymentTransaction(context,
                                otp: codeController.text,
                                phoneNumber: phoneController.text,
                                pin: passwordController.text);
                          } else {
                            errorGetBar("ادخل الرمز التأكيدي");
                          }

                        } else {
                          
                          if (passwordController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            cubit.zainPayment(context,
                                phoneNumber: phoneController.text,
                                pin: passwordController.text);
                          } else {
                            errorGetBar("ادخل رقم التليفون والرقم السري");
                          }
                        }

                        print(cubit.isCompleted);

                        // if (formKey.currentState!.validate()) {
                        // } else {
                        //   errorGetBar(AppStrings.errorOccurredText);
                        //   print('Form is Not valid');
                        // }
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

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getSize(context) / 44),
      child: Text(text, style: getMediumStyle()),
    );
  }
}
