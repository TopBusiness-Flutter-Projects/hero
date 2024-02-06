part of 'my_wallet_cubit.dart';

@immutable
abstract class MyWalletState {}

class MyWalletInitial extends MyWalletState {}

class SuccessGetWalletEmptyState extends MyWalletState {}
class SuccessGetWalletState extends MyWalletState {}
class FailureGetWalletState extends MyWalletState {}
class LoadingGetWalletStatus extends MyWalletState {}
