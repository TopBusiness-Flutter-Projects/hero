import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/core/widgets/my_svg_widget.dart';
import 'package:hero/features/signup/cubit/signup_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.type});
  final String type;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<SignupCubit, SignupState>(
  listener: (context, state) {
    // TODO: implement listener
  },
       builder: (context, state) {
       SignupCubit cubit = context.read<SignupCubit>();
       return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(getSize(context) / 16),
          child:
          Form(
            key:formKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(context) / 24,
                ),
                //back arrow
                Image.asset(
                  ImageAssets.backImage,
                  height: getSize(context) / 13,
                  width: getSize(context) / 13,

                  // height: getSize(context) / 1.2,
                  // width: getSize(context) / 1.2,
                ),
                //image picker
                SizedBox(
                  height: getSize(context) / 24,
                ),
                Center(
                  child: SizedBox(
                    child: InkWell(
                      onTap: () {
                        cubit.showImageSourceDialog(context);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          cubit.image != null?      CircleAvatar(
                              radius: 45,
                              backgroundColor: AppColors.gray.withOpacity(0.3),
                              backgroundImage:
                              FileImage(cubit.image!)

                          ):CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.gray.withOpacity(0.3),
                      backgroundImage: AssetImage("assets/images/logo.png")

                ),
                          Positioned(
                              top: getSize(context) * 0.12,
                             // right: -5,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.grey2
                                ),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},

                                    icon: Icon(
                                      Icons.camera_alt_rounded,
                                      color: AppColors.grey3,

                                    ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: getSize(context) / 22),
                  child: Text(
                    'name'.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(context) / 28),
                  ),
                ),
                // Container(
                //  height: getSize(context) / 10,
                //   padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: AppColors.gray6,
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(getSize(context) / 66))),
                //   child: Center(
                //     child:
                    CustomTextField(
                      title: 'name'.tr(),
                      controller:cubit.nameController ,
                      textInputType: TextInputType.text,
                      backgroundColor: AppColors.white,
                      prefixWidget: const Icon(CupertinoIcons.person),
                      validatorMessage: 'name_msg'.tr(),
                      horizontalPadding: 2,
                      // controller: controller.phoneNumberController,
                    ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: getSize(context) / 22),
                  child: Text(
                    'email'.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(context) / 28),
                  ),
                ),
                // Container(
                //   height: getSize(context) / 10,
                //   //  padding: EdgeInsets.symmetric(horizontal: getSize(context)/32),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: AppColors.gray6,
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(getSize(context) / 66))),
                //   child: Center(
                //     child:
                    CustomTextField(
                      title: 'email'.tr(),
                      controller: cubit.emailController,
                      textInputType: TextInputType.emailAddress,
                      backgroundColor: AppColors.white,
                      prefixWidget: const Icon(CupertinoIcons.mail),
                      validatorMessage: 'email_msg'.tr(),
                      horizontalPadding: 2,

                      // controller: controller.phoneNumberController,
                    ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: getSize(context) / 22),
                  child: Text(
                    'phone'.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(context) / 28),
                  ),
                ),
                // Container(
                //   height: getSize(context) / 10,
                //   padding:
                //       EdgeInsets.symmetric(horizontal: getSize(context) / 16),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: AppColors.gray6,
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(getSize(context) / 66))),
                //   child:
                 // Row(
                  //  children: [
                      // Text("+20",
                      //     style: TextStyle(
                      //       color: AppColors.black,
                      //       fontSize: getSize(context) / 24,
                      //     )),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 5),
                      //   child: VerticalDivider(
                      //     color: AppColors.primary,
                      //     // height: getSize(context)/10-2,
                      //     thickness: 2,
                      //   ),
                      // ),
                      CustomTextField(
                        prefixWidget:
                        SizedBox(
                          width: getSize(context)/6,
                          child: Row(
                            children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                 child: Text("+20",
                                   style: TextStyle(
                                     color: AppColors.black,
                                     fontSize: getSize(context) / 24,
                                   )),
                               ), Padding(
                                padding: const EdgeInsets.all( 5),
                                child: Container(
                                  color: AppColors.primary,
                                  //  height: getSize(context)/10-2,
                                  //  thickness: 20
                                  width: 3,
                                  height: 30,
                                ),
                              ),

                            ],
                          ),
                        ),
                        title: 'phone'.tr(),
                        controller: cubit.phoneController,
                        textInputType: TextInputType.phone,
                        backgroundColor: AppColors.white,

                        validatorMessage: 'phone_msg'.tr(),
                        horizontalPadding: 0,

                        // controller: controller.phoneNumberController,
                      ),
                  //  ],
                 // ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: getSize(context) / 22),
                  child: Text(
                    'date_of_birth'.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(context) / 28),
                  ),
                ),
                // Container(
                //   height: getSize(context) / 10,
                //   padding:
                //       EdgeInsets.symmetric(horizontal: getSize(context) / 16),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //         color: AppColors.gray6,
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(getSize(context) / 66))),
                //   child: Row(
                //     children: [
                //       MySvgWidget(
                //           path: ImageAssets.calender,
                //           imageColor: AppColors.buttonColor,
                //           size: 20),
                //       SizedBox(
                //         width: getSize(context) / 26,
                //       ),
                //       Expanded(
                //         child:
                        CustomTextField(
                          prefixWidget:Icon(CupertinoIcons.calendar_today,size: 20,),
                          // SizedBox(
                          //   width: 20,
                          //   height: 10,
                          //   child:
                          //   MySvgWidget(
                          //       path: ImageAssets.calender,
                          //       imageColor: AppColors.buttonColor,
                          //       size: 10
                          //   ),
                          // ),
                          title: 'date_of_birth'.tr(),
                          controller: cubit.dateOfBirthController,
                          textInputType: TextInputType.phone,
                          backgroundColor: AppColors.white,
                          //isEnable: false,
                          validatorMessage: 'date_of_birth_msg'.tr(),
                          horizontalPadding: 2,
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != cubit.selectedDate) {

                                cubit.selectedDate = picked;
                                cubit.dateOfBirthController.text =DateFormat('yyyy-MM-dd').format(picked);

                            }
                          },
                          // controller: controller.phoneNumberController,
                        ),
                   //   ),
                      // Flexible(
                      //   child: Text(
                      //     "1/1/2008",
                      //     style: TextStyle(
                      //         color: AppColors.gray5,
                      //         fontSize: getSize(context) / 24),
                      //     // controller: controller.phoneNumberController,
                      //   ),
                      // ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: getSize(context) / 8,
                ),
                CustomButton(
                  width: getSize(context),
                  text: "register".tr(),
                  borderRadius: getSize(context) / 24,
                  color: AppColors.primary,
                  onClick: () async {
                    if (widget.type == "client") {
                      if(formKey.currentState!.validate()){
                        if(cubit.image==null){
                          errorGetBar("pick_img".tr());
                        }
                      else{
                          await cubit.signUp("user",context);
                        }
                      }
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     Routes.homeRoute, (route) => false);
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.driversignupRoute, (route) => false);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}
