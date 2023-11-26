import 'dart:io';

class RegisterModel{
  String name;
  String? email;
  String phone;
  String birth;
  String type;
  File? image;
  String deviceType;
  String token;
  String countryCode;

  @override
  String toString() {
    return 'RegisterModel{name: $name, email: $email, phone: $phone, birth: $birth, type: $type, image: $image, deviceType: $deviceType, token: $token, countryCode  $countryCode}';
  }

  RegisterModel(
      {required this.name, this.email,required this.phone,required this.birth,required this.countryCode,
        required this.type, this.image , required this.deviceType , required this.token});
}