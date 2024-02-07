import 'package:bloc/bloc.dart';
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
    final response = await api.getDriverProfit(type: type,from: '',to: '');
    response.fold((l) {
      emit(FailureGetDriverDataState());
    }, (r) {
      if(type=='week')profitsModelWeek = r;
      if(type=='day')profitsModelDay = r;
      if(type=='custom')profitsModelCustom = r;

      emit(SuccessGetDriverDataState());

    });
  }

}
