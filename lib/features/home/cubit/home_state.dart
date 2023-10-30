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
