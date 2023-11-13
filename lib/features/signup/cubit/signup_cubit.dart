import 'dart:io';
import 'package:bloc/bloc.dart';
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


  signUp(String userType,BuildContext context)async{
  RegisterModel registerModel = RegisterModel(name: nameController.text, email: emailController.text,
    phone: "+2"+phoneController.text,
    birth: dateOfBirthController.text, type: userType,
      image:image!,
    deviceType: deviceType, token: token);
     loadingDialog();
    var response = await api.postRegister(registerModel);
    response.fold((l) {
      emit(SignUpFailed());
      Navigator.pop(context);
      errorGetBar("register failed");
    }, (r) {

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
         Navigator.pop(context);
         Navigator.of(context).pushNamedAndRemoveUntil(
             Routes.homeRoute, (route) => false);
       }
       else{

       }

    });
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
