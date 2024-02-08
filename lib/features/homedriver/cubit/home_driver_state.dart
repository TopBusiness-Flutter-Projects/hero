part of 'home_driver_cubit.dart';

@immutable
abstract class HomeDriverState {}

class HomeDriverInitial extends HomeDriverState {}
class HomeDriverInService extends HomeDriverState {}
class UpdateCurrentLocationState extends HomeDriverState {}
class UpdateDesitnationLocationState extends HomeDriverState {}
class ErrorLocationSearch extends HomeDriverState {}
class UpdateCameraPosition extends HomeDriverState {}
class LoadingChangeDriverStatusState extends HomeDriverState {}
class FailureChangeDriverStatusState extends HomeDriverState {}
class SuccessChangeDriverStatusState extends HomeDriverState {}
class LoadingGEtDriverDataState extends HomeDriverState {}
class FailureGEtDriverDataState extends HomeDriverState {}
class SuccessGEtDriverDataState extends HomeDriverState {}