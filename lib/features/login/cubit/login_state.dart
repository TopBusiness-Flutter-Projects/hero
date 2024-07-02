part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class CheckBoxState extends LoginState {}

class FailureLoginState extends LoginState {}
class SuccessLoginState extends LoginState {}
class LoadingLoginStatus extends LoginState {}
class FailureCheckDocumentsState extends LoginState {}
class SuccessCheckDocumentsState extends LoginState {}
class LoadingCheckDocumentsStatus extends LoginState {}
class PhoneBlockedtState extends LoginState {}
class PhoneNotExistState extends LoginState {}
class PhoneExistState extends LoginState {}
class CheckCodeInvalidCode extends LoginState {}
class CheckCodeSuccessfully extends LoginState {}
class OnSmsCodeSent extends LoginState {}
class NewUserAuthinticatedState extends LoginState {}
class OldUserAuthinticatedState extends LoginState {}
class SuccessCheckPhoneState extends LoginState {}
class FailureCheckPhoneState extends LoginState {}
class LoadingCheckPhoneStatus extends LoginState {}
class SuccessSendWhatsMsgState extends LoginState {}
class FailureSendWhatsMsgState extends LoginState {}
class LoadingSendWhatsMsgStatus extends LoginState {}
class SuccessCheckOTPState extends LoginState {}
class FailureCheckOTPState extends LoginState {}
class LoadingCheckOTPStatus extends LoginState {}
