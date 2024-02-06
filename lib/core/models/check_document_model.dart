// To parse this JSON data, do
//
//     final checkDocumentsModel = checkDocumentsModelFromJson(jsonString);

import 'dart:convert';

CheckDocumentsModel checkDocumentsModelFromJson(String str) => CheckDocumentsModel.fromJson(json.decode(str));

String checkDocumentsModelToJson(CheckDocumentsModel data) => json.encode(data.toJson());

class CheckDocumentsModel {
  Data? data;
  String? message;
  int? code;

  CheckDocumentsModel({
    this.data,
    this.message,
    this.code,
  });

  factory CheckDocumentsModel.fromJson(Map<String, dynamic> json) => CheckDocumentsModel(
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
  int? driverDetails;
  int? driverDocuments;

  Data({
    this.driverDetails,
    this.driverDocuments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    driverDetails: json["driver_details"],
    driverDocuments: json["driver_documents"],
  );

  Map<String, dynamic> toJson() => {
    "driver_details": driverDetails,
    "driver_documents": driverDocuments,
  };
}
