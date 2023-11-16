part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class DateUpdateState extends HomeState {}
class TimeUpdateState extends HomeState {}
class UpdateCurrentLocationState extends HomeState {}
class UpdatePlyLinesState extends HomeState {}
class UpdateCameraPosition extends HomeState {}
class OnMapCreatedState extends HomeState {}
class SearchState extends HomeState {}
class ChangeRadiState extends HomeState {}
class ChangeToRideNowState extends HomeState {}
class LoadingSearchState extends HomeState {}
class FailureSearchState extends HomeState {}
class SuccessSearchState extends HomeState {}
class UpdateDesitnationLocation extends HomeState {}
class ErrorLocationSearchState extends HomeState {}
class ErrorLocationSearchStat extends HomeState {}
class UpdateDesitnationLocationStat extends HomeState {}
class BackState extends HomeState {}
class AddMarkersState extends HomeState {}
class UpdateCurrentLocation extends HomeState {}
class GettingUserData extends HomeState {}
class GettingAddressState extends HomeState {}
class FailedDeleteUser extends HomeState {}
class SuccessDeleteUser extends HomeState {}
class ErrorGettingHomeDataState extends HomeState {}
class SuccessGettingHomeData extends HomeState {}
class LoadingHomeDataState extends HomeState {}
class LoadingToLogOutState extends HomeState {}
class FailureToLogOutState extends HomeState {}
class SuccessToLogOutState extends HomeState {}
class LoadingSettings extends HomeState {}
class FailureSettings extends HomeState {}
class SuccessSettings extends HomeState {}
class LoadingNotificationState extends HomeState {}
class FailureNotificationState extends HomeState {}
class SuccessNotificationState extends HomeState {}
class LoadingCreateTripState extends HomeState {}
class FailureCreateTrip extends HomeState {}
class SuccessCreateTripState extends HomeState {}
class ProgressState extends HomeState {}
class ProgressFinishState extends HomeState {}
class AlreadyInTrip extends HomeState {}
