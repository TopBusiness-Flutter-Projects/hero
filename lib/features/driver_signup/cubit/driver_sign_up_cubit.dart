import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/models/cities_model.dart';

import '../../../core/models/store_driver_data_model.dart';
import '../../../core/remote/service.dart';

part 'driver_sign_up_states.dart';

class DriverSignUpCubit extends Cubit<DriverSignUpStates> {
  DriverSignUpCubit(this.api) : super(DriverSignUpInitial());
  ServiceApi api;
  CitiesModel citiesModel=  CitiesModel ();


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

  StoreDriverDetailsModel storeDriverDetailsModel=  StoreDriverDetailsModel ();

  storeDriverDetails({
    required String bikeModel,
    required String bikeColor,
    required String bikeType}) async {
    emit(LoadingStoreDriverDataState());
    final response = await api.addDriverDetails(bikeType: bikeType, bikeModel: bikeModel, bikeColor: bikeColor, areaId: currentArea);
    response.fold((l) {
      emit(FailureStoreDriverDataState());
    }, (r) {
      storeDriverDetailsModel = r;
      emit(SuccessStoreDriverDataState());
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
 void changeCurrentCityId({ required int cityId}) {
   cityIndex = cityId-1;
  emit(ChangeCurrentCityIdState());


 }
 void setCityIndex() {
   cityIndex = null;
  emit(ChangeCurrentCityIdState());


 }

  String? dropdownAreaValue;

}
