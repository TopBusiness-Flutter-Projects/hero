part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class ImagePickedSuccessfully extends SignupState {}
class ImageNotPicked extends SignupState {}
class SignUpFailed extends SignupState {}
class SignUpSuccess extends SignupState {}
