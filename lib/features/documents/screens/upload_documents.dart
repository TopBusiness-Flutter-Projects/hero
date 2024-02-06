import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/core/widgets/my_svg_widget.dart';
import 'package:hero/features/documents/cubit/upload_documents_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'widgets/custom_document_widget.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  @override
  Widget build(BuildContext context) {
    UploadDocumentsCubit cubit = context.read<UploadDocumentsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(getSize(context) / 16),
        child: BlocConsumer<UploadDocumentsCubit,UploadDocumentsStates>(
           listener: (context, state) {

           },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(context) / 24,
                ),
                Row(
                  children: [
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
                      width: getSize(context) / 22,
                    ),
                    SizedBox(
                      /// height: getSize(context) / 24,
                      ///width: getSize(context),
                      child: Text("toktok_documents".tr(),
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: getSize(context) / 24,
                          )),
                    ),
                  ],
                ),
                Flexible(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: getSize(context) / 24,
                      ),


                      GestureDetector(
                        onTap: () {
                          cubit.showImageSourceDialog(context,BikeDocuments.number );
                        },
                        child: CustomDocumentWidget(
                                    img: cubit.numberImage,
                          text: "agency_number".tr(),
                        ),
                      ),

                      SizedBox(
                        height: getSize(context) / 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          GestureDetector(
                            onTap: () {
                              cubit.showImageSourceDialog(context,BikeDocuments.anniversary );
                            },
                            child: CustomDocumentWidget(
                              img: cubit.anniversaryImage,
                              text: "annual_tuktuk".tr(),
                            ),
                          ),GestureDetector(
                            onTap: () {
                              cubit.showImageSourceDialog(context,BikeDocuments.idCard );
                            },
                            child: CustomDocumentWidget(
                              img: cubit.idCardImage,
                              text: "id_card".tr(),
                            ),
                          ),


                        ],
                      ),

                      SizedBox(
                        height: getSize(context) / 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          GestureDetector(
                            onTap: () {
                              cubit.showImageSourceDialog(context,BikeDocuments.residenceCard );
                            },
                            child: CustomDocumentWidget(
                              img: cubit.residenceCardImage,
                              text: "residence_card".tr(),
                            ),
                          ), GestureDetector(
                            onTap: () {
                              cubit.showImageSourceDialog(context,BikeDocuments.photo );
                            },
                            child: CustomDocumentWidget(
                              img: cubit.photoImage,
                              text: "tuktuk_photo".tr(),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: getSize(context) / 8,
                      ),
                    ],
                  ),
                )),
                CustomButton(
                  width: getSize(context),
                  text: "continue".tr(),
                  borderRadius: getSize(context) / 24,
                  color: AppColors.primary,
                  onClick: () {
                    cubit.storeBikerDetails(context);
                    },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

