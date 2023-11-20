part of 'trip_details_cubit.dart';

@immutable
abstract class TripDetailsState {}

class TripDetailsInitial extends TripDetailsState {}
class RatingSuccessState extends TripDetailsState {}
class RatingFailedState extends TripDetailsState {}
class LoadingRatingState extends TripDetailsState {}
class AddDetailsMarkersState extends TripDetailsState {}
