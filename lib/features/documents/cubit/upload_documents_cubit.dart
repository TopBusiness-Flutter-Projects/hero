import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/models/cities_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/driver_data_model.dart';
import '../../../core/models/store_bike_details_model.dart';
import '../../../core/models/store_driver_data_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/dialogs.dart';

part 'upload_documents_states.dart';

enum BikeDocuments { number, anniversary, idCard, residenceCard, photo }

class UploadDocumentsCubit extends Cubit<UploadDocumentsStates> {
  UploadDocumentsCubit(this.api) : super(DriverSignUpInitial());
  ServiceApi api;

  void showImageSourceDialog(BuildContext context, BikeDocuments type) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('select_image'.tr()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _getImageFromGallery(context, type);
              },
              child: Text('gallery'.tr()),
            ),
            TextButton(
              onPressed: () {
                _getImageFromCamera(context, type);
              },
              child: Text("camera".tr()),
            ),
          ],
        );
      },
    );
  }

//number, anniversary, idCard, residenceCard
  File? numberImage;
  File? anniversaryImage;
  File? idCardImage;
  File? residenceCardImage;
  File? photoImage;

  Future _getImageFromCamera(BuildContext context, BikeDocuments type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      switch (type) {
        case BikeDocuments.number:
          numberImage = File(pickedFile.path);
          break;
        case BikeDocuments.anniversary:
          anniversaryImage = File(pickedFile.path);
          break;
        case BikeDocuments.idCard:
          idCardImage = File(pickedFile.path);
          break;
        case BikeDocuments.residenceCard:
          residenceCardImage = File(pickedFile.path);
          break;
        case BikeDocuments.photo:
          photoImage = File(pickedFile.path);
          break;
      }

      emit(ImagePickedSuccessfully());
    } else {
      emit(ImageNotPicked());
    }

    Navigator.pop(context); // Close the dialog after selecting an image
  }

  Future _getImageFromGallery(BuildContext context, BikeDocuments type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      switch (type) {
        case BikeDocuments.number:
          numberImage = File(pickedFile.path);
          break;
        case BikeDocuments.anniversary:
          anniversaryImage = File(pickedFile.path);
          break;
        case BikeDocuments.idCard:
          idCardImage = File(pickedFile.path);
          break;
        case BikeDocuments.residenceCard:
          residenceCardImage = File(pickedFile.path);
          break;
        case BikeDocuments.photo:
          photoImage = File(pickedFile.path);
          break;
      }
      emit(ImagePickedSuccessfully());
    } else {
      emit(ImageNotPicked());
    }

    Navigator.pop(context); // Close the dialog after selecting an image
  }



  StoreBikeDetailsModel storeBikeDetailsModel = StoreBikeDetailsModel();

  storeBikerDetails(BuildContext context) async {
    emit(LoadingStoreBikeDataState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.uploadDocuments(
        agencyNumber: numberImage!.path,
        bikeLicense: anniversaryImage!.path,
        idCard: idCardImage!.path,
        houseCard: residenceCardImage!.path,
        bikeImage: photoImage!.path);

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureStoreBikeDataState());
    }, (r) {
      storeBikeDetailsModel = r;

      Navigator.pop(context);
      successGetBar(r.message);
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.driverwaitScreenRoute, (route) => false);
      emit(SuccessStoreBikeDataState());
    });
  }
  // update

  StoreBikeDetailsModel storeBikeDetailsModelUpdate = StoreBikeDetailsModel();

  updateBikerDetails(BuildContext context) async {
    emit(LoadingUpdateBikeDataState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.uploadDocuments(isUpdate: true,
        agencyNumber:numberImage != null? numberImage!.path: null,
        bikeLicense: anniversaryImage != null? anniversaryImage!.path: null,
        idCard: idCardImage != null? idCardImage!.path: null,
        houseCard: residenceCardImage != null? residenceCardImage!.path: null,
        bikeImage: photoImage != null? photoImage!.path: null,);

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureUpdateBikeDataState());
    }, (r) {
      storeBikeDetailsModel = r;

      Navigator.pop(context);
      successGetBar(r.message);


      emit(SuccessUpdateBikeDataState());
      Navigator.pop(context);
    });
  }

String? numberImageNetwork;
String? anniversaryImageNetwork;
String? idCardImageNetwork;
String? residenceCardImageNetwork;
String? photoImageNetwork;
  DriverDataModel driverDataModel=  DriverDataModel ();

  getDriverData() async {
    emit(LoadingGEtDriverDataState());
    final response = await api.getDriverData();
    response.fold((l) {
      emit(FailureGEtDriverDataState());
    }, (r) {
      driverDataModel = r;
      numberImageNetwork =r.data!.driverDocuments![0].agencyNumber!;
      anniversaryImageNetwork =r.data!.driverDocuments![0].bikeLicense!;
      idCardImageNetwork =r.data!.driverDocuments![0].idCard!;
      residenceCardImageNetwork =r.data!.driverDocuments![0].houseCard!;
      photoImageNetwork =r.data!.driverDocuments![0].bikeImage!;
      emit(SuccessGEtDriverDataState());
    });
  }

}
