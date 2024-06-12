import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hero/core/models/login_model.dart';
import 'package:hero/core/models/signup_response_model.dart';
import 'package:hero/core/preferences/preferences.dart';
import 'package:hero/core/remote/service.dart';
import 'package:hero/core/utils/dialogs.dart';
import 'package:meta/meta.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/check_document_model.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/appwidget.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());
  ServiceApi api;
  TextEditingController phoneController = TextEditingController();
  TextEditingController codecontrol = TextEditingController();
  late LoginModel loginModel;
  bool isNewUser = true;
  bool checked = true;

  changeCheckBox(bool newValue) {
    checked = newValue;
    emit(CheckBoxState());
  }

  checkPhone(BuildContext context) async {
    // if (phoneController.text.startsWith('0')) {
    //   phoneController.text = phoneController.text.substring(1);
    //
    // }else

    emit(LoadingCheckPhoneStatus());
    AppWidget.createProgressDialog(context, 'wait'.tr());
    if (phoneController.text.startsWith("964")) {
      print("Before: ${phoneController.text}");
      phoneController.text = phoneController.text.substring(3);
      print("After: ${phoneController.text}");
    }

    //todo=> country code may be change to be iraq code
    final response = await api.checkPhone(phoneController.text);

    response.fold((l) {
      emit(FailureCheckPhoneState());
      Navigator.pop(context);
    }, (r) async {
      loginModel = r;
      // case1:new user
      if (r.code == 406) {
        //new user=> go to register
        isNewUser = true;
        print("is new User = $isNewUser");
        emit(PhoneNotExistState());
        //emit(SuccessCheckPhoneState());
        Navigator.pop(context);
        //otp request
        //todo=> firebase auth stopped for test
        // verification_Id = await verifyPhoneNumber(context);

        //
        // Navigator.pushNamedAndRemoveUntil(
        //     context, Routes.verificationScreenRoute, (route) => false);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.registerScreenRoute, (route) => false);
      }
      //case2: blocked
      else if (r.code == 500) {
        Navigator.pop(context);
        errorGetBar("this number is blocked");
        emit(PhoneBlockedtState());
        return;
      }
      //case3:old user
      else if (r.code == 200) {
        isNewUser = false;
        //old user=>go to home
        emit(PhoneExistState());
        //emit(SuccessCheckPhoneState());
        Navigator.pop(context);
        //otp request
        //todo=> firebase auth stopped for test
        // verification_Id = await verifyPhoneNumber(context);
        //
        // //
        // Navigator.pushNamedAndRemoveUntil(
        //     context, Routes.verificationScreenRoute, (route) => false);
        await login(context);
      }
      // emit(SuccessCheckPhoneState());
      // Navigator.pop(context);
      // //otp request
      // //todo=> firebase auth stopped for test
      // verification_Id = await verifyPhoneNumber(context);
      //
      //  Navigator.pushNamedAndRemoveUntil(
      //      context, Routes.verificationScreenRoute, (route) => false);
    });
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

  SignUpModel? signUpModel;

  login(BuildContext context) async {
    // if (phoneController.text.startsWith('0')) {
    //   phoneController.text = phoneController.text.substring(1);
    // }
    emit(LoadingLoginStatus());
    deviceType = Platform.isAndroid ? 'Android' : 'iOS';
    String? token = await _getId();
    AppWidget.createProgressDialog(context, 'wait'.tr());
    //todo=> country code may be change to be iraq code
    final response = await api.login(phoneController.text, deviceType, token!);

    response.fold((l) {
      Navigator.pop(context);
      errorGetBar("login failed");
      emit(FailureLoginState());
    }, (r) {
      signUpModel = r;
      // if (r.code == 406) {
      //   //new user=> go to register
      //   // isNewUser = true;
      //   Navigator.pop(context);
      //   emit(PhoneNotExistState());
      //   errorGetBar(r.message.toString());
      // } else
      if (r.code == 200) {
        emit(SuccessLoginState());
        Navigator.pop(context);
        Preferences.instance.setUser(r);

        if (r.data!.type == 'driver') {
          /// Check documents
          checkDocuments(context);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeRoute, (route) => false);
        }
      } else if (r.code == 422) {
        //new user=> go to register
        isNewUser = true;
        Navigator.pop(context);
        emit(PhoneNotExistState());
        // ErrorWidget(r.message.toString());
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.registerScreenRoute, (route) => false);
      } else {
        errorGetBar(r.message.toString());
        Navigator.pop(context);
      }
    });
  }

  // checkDocuments
  CheckDocumentsModel checkDocumentsModel = CheckDocumentsModel();

  checkDocuments(BuildContext context) async {
    emit(LoadingCheckDocumentsStatus());
    final response = await api.checkDocuments();
    response.fold((l) {
      emit(FailureCheckDocumentsState());
    }, (r) {
      checkDocumentsModel = r;
      if (r.data!.driverDetails == 1 && r.data!.driverDocuments == 1) {
        if (r.data!.status == 0)
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.driverwaitScreenRoute, (route) => false);
        else
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homedriverRoute, (route) => false);
      } else if (r.data!.driverDetails == 0) {
        Navigator.pushReplacementNamed(
          context,
          Routes.bikeDetailsRoute,
          arguments: false,
        ).then((_) {
          SystemNavigator.pop();
        });
        ;
        // Navigator.pushNamedAndRemoveUntil(
        //     context,
        //     Routes.bikeDetailsRoute,
        //     arguments: false,
        //     (route) => false);
      } else if (r.data!.driverDocuments == 0) {
        Navigator.pushReplacementNamed(
          context,
          Routes.uploadDocumentsScreenRoute,
          arguments: false,
        ).then((_) {
          SystemNavigator.pop();
        });
        ;
      }
      emit(SuccessCheckDocumentsState());
    });
  }

  int? resendToken;
  String smsCode = '';
  String? verification_Id;

  Future<String> verifyPhoneNumber(BuildContext context) async {
    Completer<String> completer = Completer();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: AppStrings.countryCode + phoneController.text,
      forceResendingToken: resendToken,
      timeout: Duration(seconds: 20),
      verificationCompleted: (PhoneAuthCredential credential) {
        //Automatic handling of the SMS code on Android devices.
        smsCode = credential.smsCode!;
        verification_Id = credential.verificationId;
        if (codecontrol.hasListeners) {
          codecontrol.text = smsCode.toString();
        }

        //verifySmsCode(smsCode);
        emit(OnSmsCodeSent());
      },
      verificationFailed: (FirebaseAuthException e) {
        //Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
        emit(CheckCodeInvalidCode());
        errorGetBar(
            "invalid phone numbers or whether the SMS quota has been exceeded.");
      },
      codeSent: (String verificationId, int? resendToken) {
        //Handle when a code has been sent to the device from Firebase, used to prompt users to enter the code.
        this.resendToken = resendToken;
        this.verification_Id = verificationId;
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //Handle a timeout of when automatic SMS code handling fails.
        Fluttertoast.showToast(msg: "timeout");
        // errorGetBar("timeout ");
      },
    );

    return completer.future;
  }

  var firebaseToken;
  var deviceType;

  verifySmsCode(String smsCode, BuildContext context) async {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(verification_Id);
    loadingDialog();
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(verification_Id);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verification_Id!,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      emit(CheckCodeSuccessfully());
      if (isNewUser) {
        Navigator.pop(context);
        emit(NewUserAuthinticatedState());
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.registerScreenRoute, (route) => false);
      } else {
        Navigator.pop(context);
        emit(OldUserAuthinticatedState());
        //todo => login api request to save user data in shared preferences
        deviceType = Platform.isAndroid ? 'Android' : 'iOS';
        login(context);
      }

      // Navigator.pop(context);
    }).catchError((error) {
      Navigator.pop(context);
      errorGetBar(error.toString());
      print('phone auth =>${error.toString()}');
    });
  }
}
