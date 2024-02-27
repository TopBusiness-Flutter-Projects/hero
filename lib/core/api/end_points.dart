class EndPoints {
  //static const String baseUrl = 'http://192.168.1.14:8000/api/';
  static const String baseUrl = 'https://hero.topbusiness.io/api/';
  static const String checkPhoneUrl = '${baseUrl}checkPhone';
  static const String loginUrl = '${baseUrl}auth/login';
  static const String homeUrl = '${baseUrl}userHome';
  static const String editProfileUrl = '${baseUrl}editProfile';
  static const String createTripUrl = '${baseUrl}createTrip';
  static const String createScheduleTripUrl = '${baseUrl}createScheduleTrip';
  static const String favouriteUrl = '${baseUrl}favouriteLocations';
  static const String cancelTripUrl = '${baseUrl}cancelUserTrip';
  static const String removeFavouriteUrl = '${baseUrl}removeFavouriteLocations';
  static const String addFavouriteUrl = '${baseUrl}createFavouriteLocations';
  static const String giveRateUrl = '${baseUrl}createTripRate';
  static const String driverLocation = '${baseUrl}driverLocation';
  static const String citiesUrl = '${baseUrl}cities';
  static const String servicesUrl = '${baseUrl}services/';
  static const String editServicesUrl = '${baseUrl}services/update/';
  static const String myServicesUrl = '${baseUrl}services/my_services';
  static const String updateProfileUrl = '${baseUrl}client/auth/update-profile';
  static const String settingsUrl = '${baseUrl}settings';
  static const String getTripStatus = '${baseUrl}getTripStatus';
  static const String allUserTripsUrl = '${baseUrl}userAllTrip';
  static const String allDriverTripsUrl = '${baseUrl}driverAllTrip';
  static const String serviceStoreUrl = '${baseUrl}services/store';
  static const String categoriesUrl = '${baseUrl}categories';
  static const String logoutUrl = '${baseUrl}logout';
  static const String deleteUrl = '${baseUrl}deleteUser';
  static const String deepLink = '${baseUrl}details/';
 // static const String searchUrl = '${baseUrl}search';
  static const String notificationUrl = '${baseUrl}notifications';
  static const String registerUrl = '${baseUrl}auth/register';
  static const String storeDriverDetails = '${baseUrl}storeDriverDetails';
  static const String storeDriverDocument = '${baseUrl}storeDriverDocument';
  static const String checkDocument = '${baseUrl}checkDocument';
  static const String driverWallet = '${baseUrl}driverWallet';
  static const String driverProfit = '${baseUrl}driverProfit';
  static const String getInfoDriver = '${baseUrl}getInfoDriver';
  static const String updateDriverDocument = '${baseUrl}updateDriverDocument';
  static const String updateDriverDetails = '${baseUrl}updateDriverDetails';
  static const String changeDriverStatus = '${baseUrl}changeStatus';
  static const String startQuickTrip = '${baseUrl}startQuickTrip';
  static const String endQuickTrip = '${baseUrl}endQuickTrip';
  static const String acceptTrip = '${baseUrl}acceptTrip';
  static const String cancelTrip = '${baseUrl}cancelTrip';
  static const String startTrip = '${baseUrl}startTrip';
  static const String endTrip = '${baseUrl}endTrip';


  //************************ Google  ****************************************************
  static const String googleBaseUrl = 'https://maps.googleapis.com/maps/api/';
  //when select any point of map give lat and lng and get the place name
  static const String geocodeUrl =  googleBaseUrl+'geocode/json';
  // give it name and get the place
  static const String searchUrl = googleBaseUrl+'place/findplacefromtext/json';
  static const String directionUrl = googleBaseUrl+'directions/json';




}
