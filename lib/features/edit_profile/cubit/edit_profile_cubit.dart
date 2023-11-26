import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/remote/service.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.api) : super(EditProfileInitial());
  ServiceApi api;
  // var token ;
  // var deviceType;
  // TextEditingController nameController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController dateOfBirthController = TextEditingController();
  // DateTime selectedDate = DateTime.now();
  // SignUpModel? signUpModel ;
  //
  // editProfile(String userType)async{
  //
  //   deviceType = deviceType = Platform.isAndroid ? 'Android' : 'iOS';
  //   SignUpModel signUpModel = await Preferences.instance.getUserModel();
  //
  //   RegisterModel registerModel = RegisterModel(name: nameController.text,
  //     email: emailController.text,
  //     phone: AppStrings.countryCode+phoneController.text,
  //     birth: dateOfBirthController.text,
  //     type: userType,
  //     image:image,
  //     deviceType: deviceType,
  //     token: signUpModel.data!.token!,);
  //  final response = await api.editProfile(registerModel)
  // }




  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

}
