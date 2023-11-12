import 'dart:io';

class RegisterModel{
  String name;
  String email;
  String phone;
  String birth;
  String type;
  File image;
  String deviceType;
  String token;

  RegisterModel(
      {required this.name,required this.email,required this.phone,required this.birth,
        required this.type,required this.image , required this.deviceType , required this.token});
}