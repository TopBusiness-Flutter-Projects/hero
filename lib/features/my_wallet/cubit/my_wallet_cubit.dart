import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hero/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/my_wallet_model.dart';

part 'my_wallet_state.dart';

class MyWalletCubit extends Cubit<MyWalletState> {
  MyWalletCubit(this.api) : super(MyWalletInitial());
  ServiceApi api;

// checkDocuments
  MyWalletModel myWalletModel = MyWalletModel();

  getWallet() async {
    emit(LoadingGetWalletStatus());
    final response = await api.getWallet();
    response.fold((l) {
      emit(FailureGetWalletState());
    }, (r) {
      myWalletModel = r;
      if (r.data == null) {
        emit(SuccessGetWalletEmptyState());
      } else {
        emit(SuccessGetWalletState());
      }
    });
  }

  // String inputDatetime = "2024-02-11 12:56:43";

 // String formattedDatetime = DateFormat('d\'${getDaySuffix(DateTime
 //     .parse(inputDatetime)
 //     .day)}\' MMM yyyy hh:mm a').format(DateTime.parse(inputDatetime));

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
}
