import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/core/models/payment_transaction_model.dart';
import 'package:hero/core/models/zain_cash_model.dart';
import 'package:hero/core/utils/app_strings.dart';
import 'package:hero/core/utils/appwidget.dart';
import 'package:hero/core/utils/dialogs.dart';

import '../../../core/remote/service.dart';

part 'payment_states.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(PaymentInitial());
  ServiceApi api;

  bool isCompleted = false;
  confirmButton() {
    isCompleted = false;
    emit(ChanfgeButtonState());
  }

  payButton() {
    isCompleted = true;
    emit(ChanfgeButtonState());
  }

  String transactionId = '';
  ZainCashModel? zainCashModel;
  zainPayment(
    BuildContext context, {
    required String phoneNumber,
    required String pin,
  }) async {
    AppWidget.createProgressDialog(context, "wait".tr());

    emit(LoadingZainCashState());
    final response = await api.zainPayment(phoneNumber: phoneNumber, pin: pin);
    print('ggggggggggl${response.runtimeType}');
    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("حدث خطأ");
     
      emit(FailureZainCashState());
    }, (r) {
      zainCashModel = r;

      if (r.processingTransaction!.success == 1) {
        Navigator.pop(context);
        successGetBar("من فضلك ادخل الرمز التأكيدي لاتمام الدفع");
        transactionId = r.processingTransaction!.transactionid.toString();
        payButton();
      } else {
        Navigator.pop(context);
        errorGetBar("تأكد من صحة المعلومات !");
      }
      emit(SuccessZainCashState());
    });
  }

  PayTransactionModel? payTransactionModel;
  paymentTransaction(
    BuildContext context, {
    required String phoneNumber,
    required String pin,
    required String otp,
  }) async {
    emit(LoadingPaymentState());
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.paymentTransaction(
        phoneNumber: phoneNumber,
        pin: pin,
        otp: otp,
        transactionId: transactionId);
    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("حدث خطأ");
      emit(FailurePaymentState());
    }, (r) {
      payTransactionModel = r;
      if (r.pay!.success == 1) {
        Navigator.pop(context);

        successGetBar("تم الدفع بنجاح");
        confirmButton();
        transactionId = '';
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        errorGetBar("حدث خطأ");
      }
      emit(SuccessPaymentState());
    });
  }
}
