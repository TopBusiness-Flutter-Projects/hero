import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/login/cubit/login_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/utils/app_colors.dart';
import '../../config/routes/app_routes.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginCubit>().codecontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        LoginCubit cubit = context.read<LoginCubit>();
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(getSize(context) / 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(context) / 16,
                  ),
                  Row(
                    children: [
                      GestureDetector(
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
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              /// height: getSize(context) / 24,
                              ///width: getSize(context),
                              child: Text("enter_code".tr(),
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                            SizedBox(
                              /// height: getSize(context) / 24,
                              ///width: getSize(context),
                              child: Text("plaase_enter_code".tr(),
                                  style: TextStyle(
                                    color: AppColors.gray3,
                                    fontSize: getSize(context) / 24,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(context) / 8,
                  ),
                  Center(
                    child: SizedBox(
                      child: Image.asset(
                        ImageAssets.verifyImage,
                        height: getSize(context) / 1.5,
                        width: getSize(context) / 2,
                        // height: getSize(context) / 1.2,
                        // width: getSize(context) / 1.2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(context) / 16,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: getSize(context) / 16),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        //      mainAxisAlignment: MainAxisAlignment.end,

                        backgroundColor: AppColors.white,
                        controller: cubit.codecontroller,
                        textStyle: TextStyle(color: AppColors.black),
                        hintStyle: TextStyle(color: AppColors.black),
                        pastedTextStyle: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),

                        appContext: context,
                        length: 5,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 4) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveColor: AppColors.gray4,
                          activeColor: AppColors.gray4,
                          shape: PinCodeFieldShape.underline,
                          selectedColor: AppColors.gray4,
                        ),
                        cursorColor: AppColors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        //  errorAnimationController: errorController,
                        keyboardType: TextInputType.number,

                        // onChanged: (value) {
                        //   // setState(() {
                        //   //   //  currentText = value;
                        //   // });
                        // },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(context) / 8,
                  ),
                  CustomButton(
                    width: getSize(context),
                    text: "follow".tr(),
                    color: AppColors.primary,
                    onClick: () async {
                      if (cubit.codecontroller.text.length == 5) {
                        //todo => stopped firebase for test

                        cubit.checkWhatsOTP(context);
                        // await cubit.verifySmsCode(

                        //     cubit.codecontroller.text, context);
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, Routes.registerScreenRoute, (route) => false);
                      } else {
                        errorGetBar("invalid code");
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   context.read<LoginCubit>().codecontrol.dispose();
  //   //context.read<LoginCubit>().codecontrol = TextEditingController();
  // }
}
