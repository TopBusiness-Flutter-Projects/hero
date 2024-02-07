part of 'profits_cubit.dart';

@immutable
abstract class ProfitsState {}

class ProfitsInitial extends ProfitsState {}
class ChangeSelectedState extends ProfitsState {}

class SuccessGetDriverDataState extends ProfitsState {}
class FailureGetDriverDataState extends ProfitsState {}
class LoadingGetDriverDataStatus extends ProfitsState {}
