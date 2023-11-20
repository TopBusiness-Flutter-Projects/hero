// To parse this JSON data, do
//
//     final rateTripModel = rateTripModelFromJson(jsonString);

import 'dart:convert';

RateTripModel rateTripModelFromJson(String str) => RateTripModel.fromJson(json.decode(str));

String rateTripModelToJson(RateTripModel data) => json.encode(data.toJson());

class RateTripModel {
  final Data? data;
  final String? message;
  final int? code;

  RateTripModel({
    this.data,
    this.message,
    this.code,
  });

  factory RateTripModel.fromJson(Map<String, dynamic> json) => RateTripModel(
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
  final int? id;
  final String? tripId;
  final int? from;
  final String? to;
  final String? rate;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.tripId,
    this.from,
    this.to,
    this.rate,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    tripId: json["trip_id"],
    from: json["from"],
    to: json["to"],
    rate: json["rate"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_id": tripId,
    "from": from,
    "to": to,
    "rate": rate,
    "description": description,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
