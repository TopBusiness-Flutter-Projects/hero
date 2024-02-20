part of 'user_trip_cubit.dart';

@immutable
abstract class UserTripState {}

class DriverTripInitial extends UserTripState {}

class RatingSuccessState extends UserTripState {}
class RatingFailedState extends UserTripState {}
class LoadingRatingState extends UserTripState {}
class AddDetailsMarkersState extends UserTripState {}
class UpdateDesitnationLocationState extends UserTripState {}
class ErrorLocationSearch extends UserTripState {}
class LoadingAcceptTripState extends UserTripState {}
class FailureAcceptTripState extends UserTripState {}
class SuccessAcceptTripState extends UserTripState {}
class LoadingStartTripState extends UserTripState {}
class FailureStartTripState extends UserTripState {}
class SuccessStartTripState extends UserTripState {}
class LoadingEndTripState extends UserTripState {}
class FailureEndTripState extends UserTripState {}
class SuccessEndTripState extends UserTripState {}
class LoadingCancelTripState extends UserTripState {}
class FailureCancelTripState extends UserTripState {}
class SuccessCancelTripState extends UserTripState {}
class LoadingRateTripState extends UserTripState {}
class FailureRateTripState extends UserTripState {}
class SuccessRateTripState extends UserTripState {}
class ChangeTripStageUIState extends UserTripState {}