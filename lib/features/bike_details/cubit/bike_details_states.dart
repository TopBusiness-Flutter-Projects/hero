part of 'bike_details_cubit.dart';


abstract class BikeDetailsStates {}

class DriverSignUpInitial extends BikeDetailsStates {}

class LoadingGEtCitiesState extends BikeDetailsStates {}
class FailureGEtCitiesState extends BikeDetailsStates {}
class SuccessGEtCitiesState extends BikeDetailsStates {}
class LoadingGEtDriverDataState extends BikeDetailsStates {}
class FailureGEtDriverDataState extends BikeDetailsStates {}
class SuccessGEtDriverDataState extends BikeDetailsStates {}
class LoadingStoreDriverDataState extends BikeDetailsStates {}
class FailureStoreDriverDataState extends BikeDetailsStates {}
class SuccessStoreDriverDataState extends BikeDetailsStates {}
class LoadingUpdateDriverDataState extends BikeDetailsStates {}
class FailureUpdateDriverDataState extends BikeDetailsStates {}
class SuccessUpdateDriverDataState extends BikeDetailsStates {}
class ChangeCityState extends BikeDetailsStates {}
class ChangeAreaState extends BikeDetailsStates {}
class ChangeCurrentCityIdState extends BikeDetailsStates {}
