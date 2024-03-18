part of 'home_driver_cubit.dart';

@immutable
abstract class HomeDriverState {}

class HomeDriverInitial extends HomeDriverState {}
class HomeDriverInService extends HomeDriverState {}
class SetInitialState extends HomeDriverState {}
class UpdateCurrentLocationState extends HomeDriverState {}
class UpdateDesitnationLocationState extends HomeDriverState {}
class ErrorLocationSearch extends HomeDriverState {}
class UpdateCameraPosition extends HomeDriverState {}
class LocationChangedState extends HomeDriverState {}
class LoadingChangeDriverStatusState extends HomeDriverState {}
class FailureChangeDriverStatusState extends HomeDriverState {}
class SuccessChangeDriverStatusState extends HomeDriverState {}
class LoadingGEtDriverDataState extends HomeDriverState {}
class FailureGEtDriverDataState extends HomeDriverState {}
class SuccessGEtDriverDataState extends HomeDriverState {}
class LoadingStartQuickTripState extends HomeDriverState {}
class FailureStartQuickTripState extends HomeDriverState {}
class SuccessStartQuickTripState extends HomeDriverState {}

class LoadingEndQuickTripState extends HomeDriverState {}
class FailureEndQuickTripState extends HomeDriverState {}
class SuccessEndQuickTripState extends HomeDriverState {}
class LoadingUpdateDriverLocationState extends HomeDriverState {}
class FailureUpdateDriverLocationState extends HomeDriverState {}
class SuccessUpdateDriverLocationState extends HomeDriverState {}
class ChangeTripStageUIState extends HomeDriverState {}
class UpdateDesitnationLocationState1 extends HomeDriverState {}
class ErrorLocationSearch1 extends HomeDriverState {}