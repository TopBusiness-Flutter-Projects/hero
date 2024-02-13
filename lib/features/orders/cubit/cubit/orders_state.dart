part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}
class SuccessGettingAllTripsState extends OrdersState {}
class FailedGettingAllTripsState extends OrdersState {}
class LoadingGettingAllTripsState extends OrdersState {}
