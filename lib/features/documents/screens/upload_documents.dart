import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/utils/assets_manager.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/core/utils/getsize.dart';
import 'package:hero/core/widgets/custom_button.dart';
import 'package:hero/features/documents/cubit/upload_documents_cubit.dart';

import '../../../core/utils/app_colors.dart';
import 'widgets/custom_document_widget.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key, this.isUpdate = false});
  final bool isUpdate;

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  @override
  void initState() {
    if (widget.isUpdate == true)
      context.read<UploadDocumentsCubit>().getDriverData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UploadDocumentsCubit cubit = context.read<UploadDocumentsCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(getSize(context) / 16),
        child: BlocConsumer<UploadDocumentsCubit, UploadDocumentsStates>(
            listener: (context, state) {},
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
                        //  if (widget.isUpdate) {
                            Navigator.pop(context);
                        //  }
                        //  SystemNavigator.pop();
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
                            cubit.showImageSourceDialog(
                                context, BikeDocuments.number);
                          },
                          child: CustomDocumentWidget(
                            networkImg: cubit.numberImageNetwork,
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
                                cubit.showImageSourceDialog(
                                    context, BikeDocuments.anniversary);
                              },
                              child: CustomDocumentWidget(
                                networkImg: cubit.anniversaryImageNetwork,
                                img: cubit.anniversaryImage,
                                text: "annual_tuktuk".tr(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.showImageSourceDialog(
                                    context, BikeDocuments.idCard);
                              },
                              child: CustomDocumentWidget(
                                networkImg: cubit.idCardImageNetwork,
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
                                cubit.showImageSourceDialog(
                                    context, BikeDocuments.residenceCard);
                              },
                              child: CustomDocumentWidget(
                                networkImg: cubit.residenceCardImageNetwork,
                                img: cubit.residenceCardImage,
                                text: "residence_card".tr(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.showImageSourceDialog(
                                    context, BikeDocuments.photo);
                              },
                              child: CustomDocumentWidget(
                                networkImg: cubit.photoImageNetwork,
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
                    text: widget.isUpdate ? "update".tr() : "continue".tr(),
                    borderRadius: getSize(context) / 24,
                    color: AppColors.primary,
                    onClick: () {
                      !widget.isUpdate
                          ? cubit.storeBikerDetails(context)
                          : cubit.idCardImage == null &&
                                  cubit.photoImage == null &&
                                  cubit.anniversaryImage == null &&
                                  cubit.residenceCardImage == null &&
                                  cubit.numberImage == null
                              ? errorGetBar('لا يوجد تعديلات')
                              : cubit.updateBikerDetails(context);
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
