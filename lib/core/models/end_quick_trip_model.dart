// To parse this JSON data, do
//
//     final endQuickTripModel = endQuickTripModelFromJson(jsonString);

import 'dart:convert';

EndQuickTripModel endQuickTripModelFromJson(String str) => EndQuickTripModel.fromJson(json.decode(str));

String endQuickTripModelToJson(EndQuickTripModel data) => json.encode(data.toJson());

class EndQuickTripModel {
  Data? data;
  String? message;
  int? code;

  EndQuickTripModel({
    this.data,
    this.message,
    this.code,
  });

  factory EndQuickTripModel.fromJson(Map<String, dynamic> json) => EndQuickTripModel(
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
  String? type;
  String? tripType;
  String? fromAddress;
  String? fromLong;
  String? fromLat;
  String? toAddress;
  String? toLong;
  String? toLat;
  String? timeRide;
  dynamic? timeArrive;
  dynamic? startTime;
  dynamic? distance;
  dynamic? time;
  dynamic price;
  dynamic? name;
  dynamic? phone;
  dynamic user;
  Driver? driver;
  dynamic? createdAt;
  dynamic? updatedAt;

  Data({
    this.id,
    this.type,this.startTime,
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    type: json["type"],
    tripType: json["trip_type"],
    fromAddress: json["from_address"],
    fromLong: json["from_long"],
    fromLat: json["from_lat"],
    toAddress: json["to_address"],
    toLong: json["to_long"],
    toLat: json["to_lat"],
    timeRide: json["time_ride"],
    timeArrive: json["time_arrive"] == null ? null : DateTime.parse(json["time_arrive"]),
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
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
    "time_ride": timeRide,
    "time_arrive": timeArrive?.toIso8601String(),
    "start_time": startTime?.toIso8601String(),
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
