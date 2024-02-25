import 'dart:convert';


import 'package:hero/core/models/signup_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;


  // Future<void> setFirstInstall() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('onBoarding', 'Done');
  // }

  // Future<String?> getFirstInstall() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? jsonData = prefs.getString('onBoarding');
  //   return jsonData;
  // }

  ////notification
  bool notiSound = true;
  bool notiVisbrate = true;
  bool notiLight = true;

  Future<void> setNotiSound({bool status = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notiSound', status);
  }

  Future<bool?> getNotiSound() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      notiSound = prefs.getBool('notiSound') ?? true;
    } catch (e) {
      notiSound = true;
    }
    return notiSound;
  }

  Future<void> setNotiVibrate({bool status = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notiVibrate', status);
  }

  Future<bool?> getNotiVibrate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      notiVisbrate = prefs.getBool('notiVibrate') ?? true;
    } catch (e) {
      notiVisbrate = true;
    }
    return notiVisbrate;
  }

  Future<void> setNotiLights({bool status = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notiLights', status);
  }

  Future<bool?> getNotiLights() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      notiLight = prefs.getBool('notiLights') ?? true;
    } catch (e) {
      notiLight = true;
    }
    return notiLight;
  }
  //////////////////////////////////
  // Notification token
  Future<String?> getNotificationToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString('notificationToken');
  }

  Future<dynamic> setNotificationToken({required String value}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return   preferences.setString('notificationToken', value);
  }
  Future<void> setUser(SignUpModel signUpModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'user', jsonEncode(SignUpModel.fromJson(signUpModel.toJson())));
    print(await getUserModel());
  }
 Future<void> clearShared()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.remove('user');
 }

  Future<SignUpModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    SignUpModel userModel;
    if (jsonData != null) {
      userModel = SignUpModel.fromJson(jsonDecode(jsonData));
    } else {
      userModel = SignUpModel();
    }
    return userModel;
  }

}
