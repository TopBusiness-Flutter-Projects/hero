// To parse this JSON data, do
//
//     final checkTripStatusModel = checkTripStatusModelFromJson(jsonString);

import 'dart:convert';

import 'package:hero/core/models/home_model.dart';

CheckTripStatusModel checkTripStatusModelFromJson(String str) =>
    CheckTripStatusModel.fromJson(json.decode(str));

String checkTripStatusModelToJson(CheckTripStatusModel data) =>
    json.encode(data.toJson());

class CheckTripStatusModel {
  NewTrip? data;
  String? message;
  int? code;

  CheckTripStatusModel({
    this.data,
    this.message,
    this.code,
  });

  factory CheckTripStatusModel.fromJson(Map<String, dynamic> json) =>
      CheckTripStatusModel(
        data: json["data"] == null ? null : NewTrip.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "code": code,
      };
}
