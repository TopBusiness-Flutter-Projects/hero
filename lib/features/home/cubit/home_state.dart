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
