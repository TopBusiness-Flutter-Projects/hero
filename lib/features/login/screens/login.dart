import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/login/cubit/login_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getSize(context) / 24),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              LoginCubit cubit = context.read<LoginCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(context) / 4,
                  ),
                  Center(
                    child: SizedBox(
                      child: Image.asset(
                        ImageAssets.loginImage,
                        height: getSize(context) / 2.5,
                        width: getSize(context) / 2,

                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(context) / 8,
                  ),
                  SizedBox(
                    child: Text("phone".tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: getSize(context) / 24,
                        )),
                  ),
                  SizedBox(
                    height: getSize(context) / 20,
                  ),
                  CustomTextField(
                    title: 'phone'.tr(),
                    controller:cubit.phoneController,
                    textInputType: TextInputType.phone,
                    backgroundColor: AppColors.white,
                    validatorMessage: 'phone_msg'.tr(),
                    horizontalPadding: 0,
                    prefixWidget:
                    Container(
                     // width: getSize(context)/6,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                8.0),
                            child: Text(AppStrings.countryCode,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: getSize(context) / 24,
                                )),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: getSize(context) / 66),
                            child: Container(
                              color: AppColors.primary,
                              // height: getSize(context)/10-2,
                              width: 3,
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // controller: controller.phoneNumberController,
                  ),
                  SizedBox(
                    height: getSize(context) / 20,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: cubit.checked,
                        onChanged: (bool? value) {
                          //todo change state
                          cubit.changeCheckBox(value!);
                        },
                        checkColor: AppColors.white,
                        //  hoverColor: AppColors.primary,
                        activeColor: AppColors.primary,
                      ),
                      Text(
                        "agreeto".tr(),
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: getSize(context) / 32),
                      ),
                      InkWell(
                        onTap: () {
                          //navigate to terms and conditions screen
                          Navigator.pushNamed(context, Routes.termsConditionsRoute);
                        },
                        child: Text(
                          "terms".tr(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: getSize(context) / 32),
                        ),
                      ),
                      Text(
                        "company".tr(),
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: getSize(context) / 32),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(context) / 8,
                  ),
                  CustomButton(
                    width: getSize(context),
                    text: "follow".tr(),
                    color: AppColors.primary,
                    onClick: () async {
                      if(cubit.checked==false){
                        errorGetBar("agree_terms".tr());
                      }
                   // else  if (cubit.phoneController.text.length<9||cubit.phoneController.text.length>10){
                    else  if (cubit.phoneController.text.length<10||cubit.phoneController.text.length>11){
                        errorGetBar("invalid number");
                      }
                    else{
                    //   await cubit.checkPhone(context);
                        await cubit.login(context);
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
