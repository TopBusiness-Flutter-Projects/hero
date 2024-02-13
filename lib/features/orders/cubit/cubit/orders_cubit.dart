import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/all_trips_model.dart';
import '../../../../core/models/home_model.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.api) : super(OrdersInitial());
  TabController? tabController ;
  ServiceApi api;
  AllTripsModel? completedTripsModel;
   List<NewTrip>? newTrips;
   List<NewTrip>? completeTrips;
   List<NewTrip>? rejectedTrips;


  getAllTrips(String type,bool isUser)async{
    emit(LoadingGettingAllTripsState());
    final response = await api.getAllTrips(type: type,isUser: isUser);
    response.fold((l) {
       emit(FailedGettingAllTripsState());
    }, (r) {
      if(r.code==200){
        if(type=="new"){
          print('....${r.data.toString()}');
          //completedTripsModel=r;
          newTrips = r.data;
          emit(SuccessGettingAllTripsState());
        }
        else if(type=="reject"){
          rejectedTrips = r.data ;
          emit(SuccessGettingAllTripsState());
        }
        else if (type == "complete"){
          completeTrips = r.data;  print('....${r.data.toString()}');
          emit(SuccessGettingAllTripsState());
        }

       // emit(SuccessGettingAllTripsState());
      }
      else{
        emit(FailedGettingAllTripsState());
      }
    });
  }
}
