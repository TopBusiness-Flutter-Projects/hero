import 'package:easy_localization/easy_localization.dart%20';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/models/cities_model.dart';

import '../../../core/models/driver_data_model.dart';
import '../../../core/models/store_driver_data_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/dialogs.dart';

part 'bike_details_states.dart';

class BikeDetailsCubit extends Cubit<BikeDetailsStates> {
  BikeDetailsCubit(this.api) : super(DriverSignUpInitial());
  ServiceApi api;
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
      required String bikeType,
      required BuildContext context}) async {
    AppWidget.createProgressDialog(context, "wait".tr());
    emit(LoadingStoreDriverDataState());
    final response = await api.addDriverDetails(
        bikeType: bikeType,
        bikeModel: bikeModel,
        bikeColor: bikeColor,
        areaId: currentArea);
    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureStoreDriverDataState());
    }, (r) {
      storeDriverDetailsModel = r;

      Navigator.pop(context);
      successGetBar(r.message);
      emit(SuccessStoreDriverDataState());
    });
  }

  StoreDriverDetailsModel storeDriverDetailsModelUpdate =
      StoreDriverDetailsModel();

  updateDriverDetails(
      {required String bikeModel,
      required String bikeColor,
      required BuildContext context,
      required String bikeType}) async {
    emit(LoadingUpdateDriverDataState());
    AppWidget.createProgressDialog(context, "wait".tr());
    final response = await api.addDriverDetails(
        bikeType: bikeType,
        bikeModel: bikeModel,
        bikeColor: bikeColor,
        areaId: currentArea,
        isUpdate: true);
    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("error".tr());
      emit(FailureUpdateDriverDataState());
    }, (r) {
      storeDriverDetailsModelUpdate = r;

      Navigator.pop(context);
      successGetBar(r.message);
      emit(SuccessUpdateDriverDataState());
    });
  }

  DriverDataModel driverDataModel = DriverDataModel();

  getDriverData() async {
    emit(LoadingGEtDriverDataState());
    final response = await api.getDriverData();
    response.fold((l) {
      emit(FailureGEtDriverDataState());
    }, (r) {
      driverDataModel = r;
      emit(SuccessGEtDriverDataState());
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
    cityIndex = cityId;
    print("city index:" + cityIndex.toString());
    emit(ChangeCurrentCityIdState());
  }

  void setCityIndex() {
    cityIndex = null;
    emit(ChangeCurrentCityIdState());
  }

  String? dropdownAreaValue;
}
