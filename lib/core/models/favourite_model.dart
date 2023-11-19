// To parse this JSON data, do
//
//     final favouriteModel = favouriteModelFromJson(jsonString);

import 'dart:convert';

FavouriteModel favouriteModelFromJson(String str) => FavouriteModel.fromJson(json.decode(str));

String favouriteModelToJson(FavouriteModel data) => json.encode(data.toJson());

class FavouriteModel {
  final List<FavouriteData>? data;
  final String? message;
  final int? code;

  FavouriteModel({
    this.data,
    this.message,
    this.code,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    data: json["data"] == null ? [] : List<FavouriteData>.from(json["data"]!.map((x) => FavouriteData.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class FavouriteData {
  final int? id;
  final int? userId;
  final String? address;
  final int? lat;
  final int? long;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  FavouriteData({
    this.id,
    this.userId,
    this.address,
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "lat": lat,
    "long": long,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
