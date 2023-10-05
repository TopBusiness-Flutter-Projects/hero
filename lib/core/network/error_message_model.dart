import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable{

  dynamic data;
  String? message;
  int? code;

  ErrorMessageModel({this.data, this.message, this.code});

  @override
  // TODO: implement props
  List<Object?> get props => [data,message,code];

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      data: json["data"],
      message: json["message"],
      code: json["code"],
    );
  }
//
}