// To parse this JSON data, do
//
//     final startQuickTripModel = startQuickTripModelFromJson(jsonString);

import 'dart:convert';

StartQuickTripModel startQuickTripModelFromJson(String str) => StartQuickTripModel.fromJson(json.decode(str));

String startQuickTripModelToJson(StartQuickTripModel data) => json.encode(data.toJson());

class StartQuickTripModel {
  StartNewTripData? data;
  String? message;
  int? code;

  StartQuickTripModel({
    this.data,
    this.message,
    this.code,
  });

  factory StartQuickTripModel.fromJson(Map<String, dynamic> json) => StartQuickTripModel(
    data: json["data"] == null ? null : StartNewTripData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class StartNewTripData {
  int? id;
  String? type;
  String? tripType;
  String? fromAddress;
  String? fromLong;
  String? fromLat;
  String? toAddress;
  String? toLong;
  String? toLat;
  dynamic timeRide;
  dynamic timeArrive;
  dynamic distance;
  dynamic time;
  dynamic price;
  String? name;
  String? phone;
  dynamic user;
  Driver? driver;
  String? createdAt;
  String? updatedAt;

  StartNewTripData({
    this.id,
    this.type,
    this.tripType,
    this.fromAddress,
    this.fromLong,
    this.fromLat,
    this.toAddress,
    this.toLong,
    this.toLat,
    this.timeRide,
    this.timeArrive,
    this.distance,
    this.time,
    this.price,
    this.name,
    this.phone,
    this.user,
    this.driver,
    this.createdAt,
    this.updatedAt,
  });

  factory StartNewTripData.fromJson(Map<String, dynamic> json) => StartNewTripData(
    id: json["id"],
    type: json["type"],
    tripType: json["trip_type"],
    fromAddress: json["from_address"],
    fromLong: json["from_long"],
    fromLat: json["from_lat"],
    toAddress: json["to_address"],
    toLong: json["to_long"],
    toLat: json["to_lat"],
    timeRide: json["time_ride"] == null ? null : DateTime.parse(json["time_ride"]),
    timeArrive: json["time_arrive"],
    distance: json["distance"],
    time: json["time"],
    price: json["price"],
    name: json["name"],
    phone: json["phone"],
    user: json["user"],
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "trip_type": tripType,
    "from_address": fromAddress,
    "from_long": fromLong,
    "from_lat": fromLat,
    "to_address": toAddress,
    "to_long": toLong,
    "to_lat": toLat,
    "time_ride": timeRide?.toIso8601String(),
    "time_arrive": timeArrive,
    "distance": distance,
    "time": time,
    "price": price,
    "name": name,
    "phone": phone,
    "user": user,
    "driver": driver?.toJson(),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Driver {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  DateTime? birth;
  String? type;
  String? status;
  String? token;


  Driver({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.birth,
    this.type,
    this.status,
    this.token,

  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    birth: json["birth"] == null ? null : DateTime.parse(json["birth"]),
    type: json["type"],
    status: json["status"],
    token: json["token"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "birth": "${birth!.year.toString().padLeft(4, '0')}-${birth!.month.toString().padLeft(2, '0')}-${birth!.day.toString().padLeft(2, '0')}",
    "type": type,
    "status": status,
    "token": token,

  };
}
