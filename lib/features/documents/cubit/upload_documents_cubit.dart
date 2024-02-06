import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/models/cities_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../config/routes/app_routes.dart';
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

  CitiesModel citiesModel = CitiesModel();

  getCities() async {
    emit(LoadingGEtCitiesState());
    final response = await api.getCities();
    response.fold((l) {
      emit(FailureGEtCitiesState());
    }, (r) {
      citiesModel = r;
      emit(SuccessGEtCitiesState());
    });
  }

  StoreDriverDetailsModel storeDriverDetailsModel = StoreDriverDetailsModel();

  storeDriverDetails(
      {required String bikeModel,
      required String bikeColor,
      required String bikeType}) async {
    emit(LoadingStoreDriverDataState());
    final response = await api.addDriverDetails(
        bikeType: bikeType,
        bikeModel: bikeModel,
        bikeColor: bikeColor,
        areaId: currentArea);
    response.fold((l) {
      emit(FailureStoreDriverDataState());
    }, (r) {
      storeDriverDetailsModel = r;
      emit(SuccessStoreDriverDataState());
    });
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

  String currentCity = '0';

  void changeCity(String value) {
    currentCity = value;
    emit(ChangeCityState());
  }

  String currentArea = '0';

  void changeArea(String value) {
    currentArea = value;
    print(currentArea);
    emit(ChangeAreaState());
  }

  int? cityIndex;

  void changeCurrentCityId({required int cityId}) {
    cityIndex = cityId - 1;
    emit(ChangeCurrentCityIdState());
  }

  void setCityIndex() {
    cityIndex = null;
    emit(ChangeCurrentCityIdState());
  }

  String? dropdownAreaValue;
}
