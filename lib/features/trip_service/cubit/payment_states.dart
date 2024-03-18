part of 'payment_cubit.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class LoadingPaymentState extends PaymentState {}
class FailurePaymentState extends PaymentState {}
class SuccessPaymentState extends PaymentState {}
class LoadingZainCashState extends PaymentState {}
class FailureZainCashState extends PaymentState {}
class SuccessZainCashState extends PaymentState {}
class ChanfgeButtonState extends PaymentState {}

