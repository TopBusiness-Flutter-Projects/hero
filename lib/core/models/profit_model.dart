// To parse this JSON data, do
//
//     final profitsModel = profitsModelFromJson(jsonString);

import 'dart:convert';

ProfitsModel profitsModelFromJson(String str) => ProfitsModel.fromJson(json.decode(str));

String profitsModelToJson(ProfitsModel data) => json.encode(data.toJson());

class ProfitsModel {
  Data? data;
  String? message;
  int? code;

  ProfitsModel({
    this.data,
    this.message,
    this.code,
  });

  factory ProfitsModel.fromJson(Map<String, dynamic> json) => ProfitsModel(
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
  int? tripsCount;
  int? totalTripsPrice;
  int? tripsDistance;
  int? kmPrice;
  int? total;
  String? vatTotal;
  double? netTotal;
  DateTime? from;
  DateTime? to;
  List<Trip>? trips;

  Data({
    this.tripsCount,
    this.totalTripsPrice,
    this.tripsDistance,
    this.kmPrice,
    this.total,
    this.vatTotal,
    this.netTotal,
    this.from,
    this.to,
    this.trips,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tripsCount: json["trips_count"],
    totalTripsPrice: json["total_trips_price"],
    tripsDistance: json["trips_distance"],
    kmPrice: json["km_price"],
    total: json["total"],
    vatTotal: json["vat_total"],
    netTotal: json["net_total"]?.toDouble(),
    from: json["from"] == null ? null : DateTime.parse(json["from"]),
    to: json["to"] == null ? null : DateTime.parse(json["to"]),
    trips: json["trips"] == null ? [] : List<Trip>.from(json["trips"]!.map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trips_count": tripsCount,
    "total_trips_price": totalTripsPrice,
    "trips_distance": tripsDistance,
    "km_price": kmPrice,
    "total": total,
    "vat_total": vatTotal,
    "net_total": netTotal,
    "from": "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
    "to": "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
    "trips": trips == null ? [] : List<dynamic>.from(trips!.map((x) => x.toJson())),
  };
}

class Trip {
  String? price;
  DateTime? day;
  String? dayName;

  Trip({
    this.price,
    this.day,
    this.dayName,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    price: json["price"],
    day: json["day"] == null ? null : DateTime.parse(json["day"]),
    dayName: json["day_name"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "day": "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
    "day_name": dayName,
  };
}
