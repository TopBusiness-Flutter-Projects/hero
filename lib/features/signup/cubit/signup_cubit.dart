import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/models/signup_response_model.dart';
import 'package:hero/core/preferences/preferences.dart';
import 'package:hero/core/remote/service.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:hero/features/signup/models/register_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_strings.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.api) : super(SignupInitial());
  ServiceApi api;
  var token;
  var deviceType;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  SignUpModel? signUpModel;
  SignUpModel? sharedUserData;
  signUp(String userType, BuildContext context, bool isSignUp) async {
    String? deviceId = await _getId();
    SignUpModel? signUpModel = await Preferences.instance.getUserModel();
    deviceType = deviceType = Platform.isAndroid ? 'Android' : 'iOS';
    final RegExp regExp = RegExp(r'^964');
    if (regExp.hasMatch(phoneController.text)) {
      phoneController.text = phoneController.text.replaceFirst(regExp, '');
    }
    RegisterModel registerModel = RegisterModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      birth: dateOfBirthController.text,
      type: userType,
      image: image,
      deviceType: deviceType,
      token: isSignUp ? deviceId! : signUpModel.data!.token!,
      countryCode: AppStrings.countryCode,
    );
    print("2222222222222222222222222222222222222");
    print(registerModel);
    loadingDialog();
    var response = await api.postRegister(registerModel, isSignUp);
    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("فشل تسجيل الدخول");  emit(SignUpFailed());
    }, (r) async {
    if (r.code == 200) {


        emit(SignUpSuccess());
        signUpModel = r;
        Preferences.instance.setUser(r);
        sharedUserData = await Preferences.instance.getUserModel();
        Navigator.pop(context);
        if (userType == "user") {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.requestlocationScreenRoute, (route) => false,
              arguments: "client");
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.requestlocationScreenRoute, (route) => false,
              arguments: "driver");
        }
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        dateOfBirthController.clear();
      } else {
        Navigator.pop(context);
        errorGetBar("${r.message}");
      }
    });
  }
/*   if (r.code == 401||r.code==201) {
        Navigator.pop(context);
        errorGetBar("${r.message}");
      } else
*
*
* */
  getUserData() async {
    sharedUserData = await Preferences.instance.getUserModel();
    if (sharedUserData != null) {

      nameController.text = sharedUserData!.data!.name!;
      emailController.text = (sharedUserData!.data!.email != null
          ? sharedUserData!.data!.email
          : "")!;

      if (sharedUserData!.data!.phone!.contains('+964'))
        phoneController.text = sharedUserData!.data!.phone!.replaceAll("+964", "");
      else
      phoneController.text = sharedUserData!.data!.phone!;
      dateOfBirthController.text =
          sharedUserData!.data!.birth!.toString().substring(0, 10);
    }
    emit(GettingUserDataState());
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  void showImageSourceDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('select_image'.tr()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _getImageFromGallery(context);
              },
              child: Text('gallery'.tr()),
            ),
            TextButton(
              onPressed: () {
                _getImageFromCamera(context);
              },
              child: Text("camera".tr()),
            ),
          ],
        );
      },
    );
  }

  File? image;

  Future _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImagePickedSuccessfully());
    } else {
      emit(ImageNotPicked());
    }

    Navigator.pop(context); // Close the dialog after selecting an image
  }

  Future _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImagePickedSuccessfully());
    } else {
      emit(ImageNotPicked());
    }

    Navigator.pop(context); // Close the dialog after selecting an image
  }

  editProfile(String userType, BuildContext context) async {
    SignUpModel? signUpModel = await Preferences.instance.getUserModel();
    deviceType = deviceType = Platform.isAndroid ? 'Android' : 'iOS';

    RegisterModel registerModel = RegisterModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      birth: dateOfBirthController.text,
      type: userType,
      image: image,
      deviceType: deviceType,
      token: signUpModel.data!.token!,
      countryCode: AppStrings.countryCode,
    );
    print("2222222222222222222222222222222222222");
    print(registerModel);
    emit(LoadingEditProfileState());
    loadingDialog();
    var response = await api.editProfile(
      registerModel,
    );
    response.fold((l) {
      emit(EditProfileFailed());
      Navigator.pop(context);
      errorGetBar(l.toString());
    }, (r) async {
      if (r.code == 406) {
        Navigator.pop(context);
        errorGetBar("${r.message}");
      } else if (r.code == 408) {
        Navigator.pop(context);
        errorGetBar("${r.message}");
      } else if (r.code == 200) {
        emit(EditProfileSuccess());
        signUpModel = r;
        Preferences.instance.setUser(r);
        sharedUserData = await Preferences.instance.getUserModel();
        Navigator.pop(context);
        if (userType == "user") {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.requestlocationScreenRoute, (route) => false,
              arguments: "client");
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context, Routes.homedriverRoute, (route) => false,
          );
        }
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     Routes.homeRoute, (route) => false);
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        dateOfBirthController.clear();
      } else {
        Navigator.pop(context);
        print("r = ${r.message}");
        errorGetBar("${r.message}");
      }
    });
  }
}
