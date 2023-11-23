import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
  var token ;
  var deviceType;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  SignUpModel? signUpModel ;

SignUpModel? sharedUserData;
  signUp(String userType,BuildContext context,bool isSignUp)async{
    String? deviceId = await _getId();
    deviceType = deviceType = Platform.isAndroid ? 'Android' : 'iOS';
  RegisterModel registerModel = RegisterModel(name: nameController.text, email: emailController.text,
    phone: AppStrings.countryCode+phoneController.text,
    birth: dateOfBirthController.text, type: userType,
      image:image,
    deviceType: deviceType, token: deviceId!);
  print("2222222222222222222222222222222222222");
  print(registerModel);
     loadingDialog();
    var response = await api.postRegister(registerModel,isSignUp);
    response.fold((l) {
      emit(SignUpFailed());
      Navigator.pop(context);
      errorGetBar("register failed");
    }, (r) async {

       if (r.code==406){
         Navigator.pop(context);
         errorGetBar("${r.message}");
      }
       else if (r.code==408){
         Navigator.pop(context);
         errorGetBar("${r.message}");
       }
       else   if(r.code==200){
         emit(SignUpSuccess());
         signUpModel = r ;
         Preferences.instance.setUser(r);
        sharedUserData = await Preferences.instance.getUserModel();
         Navigator.pop(context);
         if(userType=="user"){
           Navigator.pushNamedAndRemoveUntil(context, Routes.requestlocationScreenRoute, (route) => false,arguments: "client");
         }
         else{
           Navigator.pushNamedAndRemoveUntil(context, Routes.requestlocationScreenRoute, (route) => false,arguments: "driver");
         }
         // Navigator.of(context).pushNamedAndRemoveUntil(
         //     Routes.homeRoute, (route) => false);
         nameController.clear();
         phoneController.clear();
         emailController.clear();
         dateOfBirthController.clear();
       }
       else{
         Navigator.pop(context);
         errorGetBar("${r.message}");
       }

    });
  }
  getUserData() async {
    sharedUserData = await Preferences.instance.getUserModel();
    emit(GettingUserDataState());
  }
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

    void showImageSourceDialog(BuildContext context)async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Image Source"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _getImageFromGallery(context);
                },
                child: Text("Gallery"),
              ),
              TextButton(
                onPressed: () {
                  _getImageFromCamera(context);
                },
                child: Text("Camera"),
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
      }
      else{
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
      }
      else{
        emit(ImageNotPicked());
      }

    Navigator.pop(context); // Close the dialog after selecting an image
  }


}
