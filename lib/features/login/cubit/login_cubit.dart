import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:hero/core/models/login_model.dart';
import 'package:hero/core/models/signup_response_model.dart';
import 'package:hero/core/preferences/preferences.dart';
import 'package:hero/core/remote/service.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/widgets/show_loading_indicator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());
  ServiceApi api;
  TextEditingController phoneController = TextEditingController();
  TextEditingController codecontrol = TextEditingController();
 late LoginModel loginModel;
 bool isNewUser = true;
  checkPhone(BuildContext context)async{
    emit(LoadingCheckPhoneStatus());
    AppWidget.createProgressDialog(context, 'wait'.tr());
    //todo=> country code may be change to be iraq code
    final response =await api.checkPhone(phoneController.text, "+2");

    response.fold(
            (l) {
              emit(FailureCheckPhoneState());
              Navigator.pop(context);

            },
            (r) {
              loginModel = r;
              if(r.code==406){
                //new user=> go to register
                isNewUser = true;
                emit(PhoneNotExistState());
              }
              else if(r.code == 200){
                isNewUser = false;
                //old user=>go to home
                emit(PhoneExistState());
              }
              emit(SuccessCheckPhoneState());
              Navigator.pop(context);
              //otp request
              verifyPhoneNumber(context);
              Navigator.pushNamedAndRemoveUntil(context,
                  Routes.verificationScreenRoute, (route) => false);

            });
  }


  SignUpModel? signUpModel;
  login(BuildContext context)async{
    emit(LoadingLoginStatus());
    AppWidget.createProgressDialog(context, 'wait'.tr());
    //todo=> country code may be change to be iraq code
    final response =await api.login(phoneController.text, "+2",deviceType,firebaseToken);

    response.fold(
            (l) {
          emit(FailureLoginState());
          Navigator.pop(context);

        },
            (r) {
          signUpModel = r;
          if(r.code==406){
            //new user=> go to register
           // isNewUser = true;
            Navigator.pop(context);
            emit(PhoneNotExistState());
          }
          else if(r.code == 200){
            emit(SuccessLoginState());
            Navigator.pop(context);
            Preferences.instance.setUser(r);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeRoute, (route) => false);
          }
          else{
            Navigator.pop(context);
            ErrorWidget(r.message.toString());
          }



        });
  }



  int? resendToken;
  String smsCode = '';
  String? verification_Id;

  verifyPhoneNumber(BuildContext context)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+2"+phoneController.text,
      forceResendingToken: resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        //Automatic handling of the SMS code on Android devices.
        smsCode = credential.smsCode!;
        verification_Id = credential.verificationId;
        if(codecontrol.hasListeners){
          codecontrol.text=smsCode.toString();
        }

        //verifySmsCode(smsCode);
        emit(OnSmsCodeSent());
      },
      verificationFailed: (FirebaseAuthException e) {
        //Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
        emit(CheckCodeInvalidCode());
      },
      codeSent: (String verificationId, int? resendToken) {
        //Handle when a code has been sent to the device from Firebase, used to prompt users to enter the code.
        this.resendToken = resendToken;
        this.verification_Id = verificationId;
        print("verificationId=>${verificationId}");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //Handle a timeout of when automatic SMS code handling fails.
      },
    );
  }

  // sendSmsCode({String? code, String? phoneNum}) async {
  //   if(phoneNum!.startsWith("0")){
  //     phoneNum = phoneNum.substring(1,11);
  //   }
  //
  //   //emit(SendCodeLoading());
  //   await FirebaseAuth.instance.setSettings(forceRecaptchaFlow: true);
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //
  //   //  phoneNumber: '${code ?? phoneCode}' + "${phoneNum ?? phoneController.text}",
  //     timeout: Duration(seconds: 25),
  //
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //   //    smsCode = credential.smsCode!;
  //       // verification_Id = credential.verificationId;
  //       // print("_____________________________________________ $verification_Id");
  //       // print("verificationId=$verification_Id");
  //       // if(codecontrol.hasListeners){
  //       //   codecontrol.text=smsCode.toString();
  //       // }
  //       // verifySmsCode(smsCode);
  //       // emit(OnSmsCodeSent(smsCode));
  //       //  verifySmsCode(smsCode);
  //     },
  //
  //     codeSent: (String verificationId, int? resendToken) {
  //       this.resendToken = resendToken;
  //       this.verification_Id = verificationId;
  //
  //       print("verificationId=>${verificationId}");
  //
  //       emit(OnSmsCodeSent());
  //     },
  //
  //
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = verificationId;
  //     },
  //   );
  // }


  var firebaseToken;
  var deviceType;

  verifySmsCode(String smsCode,BuildContext context) async {
   print("************************************************");
    print(smsCode);
    print(verification_Id);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verification_Id!,
      smsCode: smsCode,
    );
    await  FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      // var model= await Preferences.instance.getUserModel();
      if(isNewUser){
        emit(NewUserAuthinticatedState());
      }
      else{
        emit(OldUserAuthinticatedState());
      }
    //  Get.offAndToNamed(Routes.resetPasswordRoute);

      emit(CheckCodeSuccessfully());
      //  if(model.data==null){
      //    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
      //    print(model.data);
      //    emit(ModelDoesNotExist());
      //
      //  }else{
      //    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
      //    print(model.data!.user!.name);
      //    emit(ModelExistState());
      //    Get.offAndToNamed(Routes.homeRoute);
      //
      // }

      if(isNewUser){
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.usertypeScreenRoute, (route) => false);
      }
      else{
        //todo => login api request to save user data in shared preferences
        FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
      await  _firebaseMessaging.getToken().then((token){
          print("token is $token");
          print("***************************************** token ");
          firebaseToken = token ;
        });
        deviceType = Platform.isAndroid ? 'Android' : 'iOS';
        login(context);

      }


    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });
  }
}
