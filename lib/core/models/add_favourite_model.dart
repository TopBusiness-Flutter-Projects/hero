// To parse this JSON data, do
//
//     final addFavouriteModel = addFavouriteModelFromJson(jsonString);

import 'dart:convert';

AddFavouriteModel addFavouriteModelFromJson(String str) => AddFavouriteModel.fromJson(json.decode(str));

String addFavouriteModelToJson(AddFavouriteModel data) => json.encode(data.toJson());

class AddFavouriteModel {
  final Data? data;
  final String? message;
  final int? code;

  AddFavouriteModel({
    this.data,
    this.message,
    this.code,
  });

  factory AddFavouriteModel.fromJson(Map<String, dynamic> json) => AddFavouriteModel(
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
  final int? userId;
  final String? address;
  final String? lat;
  final String? long;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.userId,
    this.address,
    this.lat,
    this.long,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "address": address,
    "lat": lat,
    "long": long,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
