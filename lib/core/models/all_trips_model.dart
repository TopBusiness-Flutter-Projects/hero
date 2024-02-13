// To parse this JSON data, do
//
//     final allTripsModel = allTripsModelFromJson(jsonString);

import 'dart:convert';

import 'home_model.dart';

AllTripsModel allTripsModelFromJson(String str) => AllTripsModel.fromJson(json.decode(str));

String allTripsModelToJson(AllTripsModel data) => json.encode(data.toJson());

class AllTripsModel {
  List<NewTrip>? data;
  String? message;
  int? code;

  AllTripsModel({
    this.data,
    this.message,
    this.code,
  });

  factory AllTripsModel.fromJson(Map<String, dynamic> json) => AllTripsModel(
    data: json["data"] == null ? [] : List<NewTrip>.from(json["data"]!.map((x) => NewTrip.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

