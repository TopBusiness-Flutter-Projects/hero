// To parse this JSON data, do
//
//     final updateDriverLocationModel = updateDriverLocationModelFromJson(jsonString);

import 'dart:convert';

UpdateDriverLocationModel updateDriverLocationModelFromJson(String str) => UpdateDriverLocationModel.fromJson(json.decode(str));

String updateDriverLocationModelToJson(UpdateDriverLocationModel data) => json.encode(data.toJson());

class UpdateDriverLocationModel {
  String? message;
  int? code;

  UpdateDriverLocationModel({
    this.message,
    this.code,
  });

  factory UpdateDriverLocationModel.fromJson(Map<String, dynamic> json) => UpdateDriverLocationModel(
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
  };
}
