part of 'driver_sign_up_cubit.dart';


abstract class DriverSignUpStates {}

class DriverSignUpInitial extends DriverSignUpStates {}

class LoadingGEtCitiesState extends DriverSignUpStates {}
class FailureGEtCitiesState extends DriverSignUpStates {}
class SuccessGEtCitiesState extends DriverSignUpStates {}
class LoadingStoreDriverDataState extends DriverSignUpStates {}
class FailureStoreDriverDataState extends DriverSignUpStates {}
class SuccessStoreDriverDataState extends DriverSignUpStates {}
class ChangeCityState extends DriverSignUpStates {}
class ChangeAreaState extends DriverSignUpStates {}
class ChangeCurrentCityIdState extends DriverSignUpStates {}
