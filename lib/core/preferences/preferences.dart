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

  Future<void> setUser(SignUpModel signUpModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'user', jsonEncode(SignUpModel.fromJson(signUpModel.toJson())));
    print(await getUserModel());
  }
 Future<void> clearShared()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.clear();
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
