import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:hero/features/home/cubit/home_cubit.dart';
import 'package:hero/features/signup/cubit/signup_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/back_button.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/my_svg_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key,});


  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var formKey = GlobalKey<FormState>(debugLabel: "editprofile");
   String? type;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
   context.read<SignupCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    SignupCubit cubit = context.read<SignupCubit>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
           padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          //welcome mohammed
                          Row(

                            children: [
                              CustomBackButton(),
                              SizedBox(width: 5,),
                              Icon(
                                CupertinoIcons.person_circle_fill,
                                color: Colors.grey,
                              ),
                              Text(
                                'welcome'.tr() + "${context.read<HomeCubit>().signUpModel?.data?.name}",
                                style: TextStyle(
                                    fontSize: getSize(context) / 24,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.black),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //address + location icon
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 27,
                              ),
                              //address

                                  Expanded(
                                    child: Text(
                                      "${context.read<HomeCubit>().address}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: getSize(context) / 24,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.gray),
                                    ),
                                  ),

                            ],
                          ),
                          SizedBox(height: 10,),

                         InkWell(
                           onTap: () {
                             cubit.showImageSourceDialog(context);
                           },
                           child:
                           Stack(
                             alignment: Alignment.bottomRight,
                             children: [
                               cubit.image != null? CircleAvatar(
                                   radius: 45,
                                   backgroundColor: AppColors.gray.withOpacity(0.3),
                                   backgroundImage:
                                  FileImage(cubit.image!)


                               ):CircleAvatar(
                                   radius: 45,
                                   backgroundColor: AppColors.gray.withOpacity(0.3),
                                   backgroundImage: NetworkImage(context.read<HomeCubit>().signUpModel?.data?.image??"https://ps.w.org/one-user-avatar/assets/icon-256x256.png?rev=2536829")
                                   //AssetImage("assets/images/logo.png")

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
                           // Stack(
                           //   children: [
                           //     CircleAvatar(
                           //       radius: getSize(context)/7,
                           //         backgroundColor: AppColors.grey3.withOpacity(0.3),
                           //         child: Icon(Icons.person,size: getSize(context)/4,color: AppColors.grey1,)),
                           //     Positioned(
                           //       bottom: getSize(context)*0.005,
                           //         right: 0,
                           //         child: CircleAvatar(
                           //             radius: getSize(context)/20,
                           //             backgroundColor: AppColors.grey1,
                           //             child: Icon(Icons.camera_alt_rounded,size: getSize(context)/14,
                           //               color: AppColors.grey3,)), )
                           //   ],
                           // ),
                         ),


                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: getSize(context) / 30),
                                child: Text("name".tr(),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: getSize(context) / 24,
                                    )),
                              ),
                            ],
                          ),
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

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                                child: Text("email".tr(),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: getSize(context) / 24,
                                    )),
                              ),
                            ],
                          ),

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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Text("phone".tr(),
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: getSize(context) / 24,
                                      )),
                                ],
                              ),
                            ),
                          ),
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
                          // Container(
                          //   height: getSize(context)/10,
                          //   padding: EdgeInsets.symmetric(horizontal: getSize(context)/16),
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: AppColors.gray6),
                          //       borderRadius: BorderRadius.all(
                          //           Radius.circular(getSize(context) / 22))),
                          //   child: Row(
                          //     children: [
                          //       Text("+20",
                          //           style: TextStyle(
                          //             color: AppColors.black,
                          //             fontSize: getSize(context) / 24,
                          //           )),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 1.0),
                          //         child: VerticalDivider(
                          //           color: AppColors.primary,
                          //           // height: getSize(context)/10-2,
                          //           thickness: 1,
                          //
                          //
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: CustomTextField(
                          //           title: 'phone'.tr(),
                          //           textInputType: TextInputType.phone,
                          //           backgroundColor: AppColors.white,
                          //
                          //           validatorMessage: 'phone_msg'.tr(),
                          //           horizontalPadding: 2,
                          //
                          //           // controller: controller.phoneNumberController,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                            child: SizedBox(

                              child: Row(
                                children: [
                                  Text("birth_date".tr(),
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: getSize(context) / 24,
                                      )),
                                ],
                              ),
                            ),
                          ),
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
                          // Container(
                          //   height: getSize(context)/10,
                          //   padding: EdgeInsets.symmetric(horizontal: getSize(context)/16),
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: AppColors.gray6),
                          //       borderRadius: BorderRadius.all(
                          //           Radius.circular(getSize(context) / 22))),
                          //   child: Row(
                          //     children: [
                          //       MySvgWidget(path: ImageAssets.calender, imageColor: AppColors.buttonColor, size: 20),
                          //    SizedBox(width: 10,),
                          //       Expanded(
                          //         child: Text(
                          //           "1/1/2008",
                          //           style: TextStyle(color: AppColors.gray5,fontSize: getSize(context)/24),
                          //           // controller: controller.phoneNumberController,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: getSize(context) / 8,
                          ),
                          CustomButton(
                            width: getSize(context),
                            text: "confirm".tr(),
                            borderRadius: getSize(context) / 24,
                            color: AppColors.primary,
                            onClick: () async {
                             // type == "client";
                             // if (type == "client") {
                                if(formKey.currentState!.validate()){
                                  if(cubit.image==null){
                                    errorGetBar("pick_img".tr());
                                  }
                                  else{

                                    await cubit.signUp("user",context,true);
                                  }
                                }
                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                //     Routes.homeRoute, (route) => false);
                          //    }
                              //else {
                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                //     Routes.driversignupRoute, (route) => false);
                            //  }
                            },
                           //  onClick: () async {
                           // await  cubit.signUp("user", context,false);
                           //   // Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeRoute, (route) => false);
                           //
                           //  },
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
