class EndPoints {
  static const String baseUrl = 'https://khdamat.topbusiness.io/api/';
  static const String loginUrl = '${baseUrl}auth/login';
  static const String homeUrl = '${baseUrl}home';
  static const String citiesUrl = '${baseUrl}cities';
  static const String servicesUrl = '${baseUrl}services/';
  static const String editServicesUrl = '${baseUrl}services/update/';
  static const String favoriteUrl = '${baseUrl}services/get-favourites';
  static const String myServicesUrl = '${baseUrl}services/my_services';
  static const String updateProfileUrl = '${baseUrl}client/auth/update-profile';
  static const String settingUrl = '${baseUrl}setting';
  static const String serviceStoreUrl = '${baseUrl}services/store';
  static const String categoriesUrl = '${baseUrl}categories';
  static const String rateUrl = '${baseUrl}services/add-rate';
  static const String addToFavouriteUrl = '${baseUrl}services/add-to-favourites';
  static const String deepLink = '${baseUrl}details/';
 // static const String searchUrl = '${baseUrl}search';
  static const String notificationUrl = '${baseUrl}notifications';
  static const String registerUrl = '${baseUrl}client/auth/register';


  //************************ Google  ****************************************************
  static const String googleBaseUrl = 'https://maps.googleapis.com/maps/api/';
  //when select any point of map give lat and lng and get the place name
  static const String geocodeUrl =  googleBaseUrl+'geocode/json';
  // give it name and get the place
  static const String searchUrl = googleBaseUrl+'place/findplacefromtext/json';




}
