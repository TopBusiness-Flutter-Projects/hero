part of 'driver_trip_cubit.dart';

@immutable
abstract class DriverTripState {}

class DriverTripInitial extends DriverTripState {}

class RatingSuccessState extends DriverTripState {}
class RatingFailedState extends DriverTripState {}
class LoadingRatingState extends DriverTripState {}
class AddDetailsMarkersState extends DriverTripState {}

class LoadingAcceptTripState extends DriverTripState {}
class FailureAcceptTripState extends DriverTripState {}
class SuccessAcceptTripState extends DriverTripState {}
class LoadingStartTripState extends DriverTripState {}
class FailureStartTripState extends DriverTripState {}
class SuccessStartTripState extends DriverTripState {}
class LoadingEndTripState extends DriverTripState {}
class FailureEndTripState extends DriverTripState {}
class SuccessEndTripState extends DriverTripState {}
class LoadingCancelTripState extends DriverTripState {}
class FailureCancelTripState extends DriverTripState {}
class SuccessCancelTripState extends DriverTripState {}
class LoadingRateTripState extends DriverTripState {}
class FailureRateTripState extends DriverTripState {}
class SuccessRateTripState extends DriverTripState {}
class ChangeTripStageUIState extends DriverTripState {}