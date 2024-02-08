import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hero/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/my_wallet_model.dart';
import '../../../core/models/profit_model.dart';

part 'profits_state.dart';

class ProfitsCubit extends Cubit<ProfitsState> {
  ProfitsCubit(this.api) : super(ProfitsInitial());
  ServiceApi api;

  // 0 for today , 1 for week ,2 for report
  int selected = 0;

  void todaySelect(){
    selected =0;
    emit(ChangeSelectedState());
  }
    void weekSelect(){
    selected =1;
    emit(ChangeSelectedState());
  }
    void reportSelect(){
    selected =2;
    emit(ChangeSelectedState());
  }

/// date

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  DateTime fromSelectedDate = DateTime.now();
  DateTime toSelectedDate = DateTime.now();

// get profits
  ProfitsModel profitsModelWeek=  ProfitsModel ();
  ProfitsModel profitsModelDay=  ProfitsModel ();
  ProfitsModel profitsModelCustom=  ProfitsModel ();

  getProfits(String type) async {
    emit(LoadingGetDriverDataStatus());
    final response = await api.getDriverProfit(type: type,from: fromController.text,to: toController.text);
    response.fold((l) {
      emit(FailureGetDriverDataState());
    }, (r) {
      if(type=='week')profitsModelWeek = r;
      if(type=='day')profitsModelDay = r;
      if(type=='custom')profitsModelCustom = r;

      emit(SuccessGetDriverDataState());

    });
  }

  String changeDateFormat(String date){


    String formattedDate = DateFormat('d\'${getDaySuffix(DateTime.parse(date).day)}\' MMM yyyy').format(DateTime.parse(date));

return formattedDate;
  }

  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());



}
String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}