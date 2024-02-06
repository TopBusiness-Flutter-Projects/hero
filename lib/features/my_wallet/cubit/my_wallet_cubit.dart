import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hero/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/my_wallet_model.dart';

part 'my_wallet_state.dart';

class MyWalletCubit extends Cubit<MyWalletState> {
  MyWalletCubit(this.api) : super(MyWalletInitial());
  ServiceApi api;
// checkDocuments
  MyWalletModel myWalletModel=  MyWalletModel ();

  getWallet() async {
    emit(LoadingGetWalletStatus());
    final response = await api.getWallet();
    response.fold((l) {
      emit(FailureGetWalletState());
    }, (r) {
      myWalletModel = r;
      if (r.data == null){
        emit(SuccessGetWalletEmptyState());
      }else{
        emit(SuccessGetWalletState());
      }


    });
  }

}
