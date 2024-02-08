// To parse this JSON data, do
//
//     final checkStatusModel = checkStatusModelFromJson(jsonString);

import 'dart:convert';

CheckStatusModel checkStatusModelFromJson(String str) => CheckStatusModel.fromJson(json.decode(str));

String checkStatusModelToJson(CheckStatusModel data) => json.encode(data.toJson());

class CheckStatusModel {
  Data? data;
  String? message;
  int? code;

  CheckStatusModel({
    this.data,
    this.message,
    this.code,
  });

  factory CheckStatusModel.fromJson(Map<String, dynamic> json) => CheckStatusModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  int? status;

  Data({
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
