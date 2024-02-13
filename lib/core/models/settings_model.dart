// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromJson(String str) => SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  final Data? data;
  final String? message;
  final int? code;

  SettingsModel({
    this.data,
    this.message,
    this.code,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
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
  final String? tripInsurance;
  final String? rewards;
  final String? about;
  final String? support;
  final String? safetyRoles;
  final String? polices;
  final String? phone;

  final int? km;
  final int? vat;

  Data( {
    this.tripInsurance,
    this.rewards,this.phone,
    this.about,
    this.support,
    this.safetyRoles,
    this.polices,
    this.km,
    this.vat,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tripInsurance: json["trip_insurance"],
    rewards: json["rewards"],
    about: json["about"],
    support: json["support"],
    phone: json["phone"],
    safetyRoles: json["safety_roles"],
    polices: json["polices"],
    km: json["km"],
    vat: json["vat"],
  );

  Map<String, dynamic> toJson() => {
    "trip_insurance": tripInsurance,
    "rewards": rewards,
    "about": about,
    "support": support,
    "phone": phone,
    "safety_roles": safetyRoles,
    "polices": polices,
    "km": km,
    "vat": vat,
  };
}
