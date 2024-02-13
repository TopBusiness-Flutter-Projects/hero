// To parse this JSON data, do
//
//     final rateModel = rateModelFromJson(jsonString);

import 'dart:convert';

RateModel rateModelFromJson(String str) => RateModel.fromJson(json.decode(str));

String rateModelToJson(RateModel data) => json.encode(data.toJson());

class RateModel {
  Data? data;
  String? message;
  int? code;

  RateModel({
    this.data,
    this.message,
    this.code,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
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
  int? id;
  String? tripId;
  int? from;
  int? to;
  String? rate;
  String? description;

  Data({
    this.id,
    this.tripId,
    this.from,
    this.to,
    this.rate,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    tripId: json["trip_id"],
    from: json["from"],
    to: json["to"],
    rate: json["rate"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_id": tripId,
    "from": from,
    "to": to,
    "rate": rate,
    "description": description,
  };
}
