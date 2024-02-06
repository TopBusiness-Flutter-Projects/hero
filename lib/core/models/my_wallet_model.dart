// To parse this JSON data, do
//
//     final myWalletModel = myWalletModelFromJson(jsonString);

import 'dart:convert';

MyWalletModel myWalletModelFromJson(String str) => MyWalletModel.fromJson(json.decode(str));

String myWalletModelToJson(MyWalletModel data) => json.encode(data.toJson());

class MyWalletModel {
  Data? data;
  String? message;
  int? code;

  MyWalletModel({
    this.data,
    this.message,
    this.code,
  });

  factory MyWalletModel.fromJson(Map<String, dynamic> json) => MyWalletModel(
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
  String? vatTotal;
  List<Trip>? trips;

  Data({
    this.vatTotal,
    this.trips,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    vatTotal: json["vat_total"],
    trips: json["trips"] == null ? [] : List<Trip>.from(json["trips"]!.map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vat_total": vatTotal,
    "trips": trips == null ? [] : List<dynamic>.from(trips!.map((x) => x.toJson())),
  };
}

class Trip {
  int? id;
  double? vat;
  DateTime? timeArrive;

  Trip({
    this.id,
    this.vat,
    this.timeArrive,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    id: json["id"],
    vat: json["vat"]?.toDouble(),
    timeArrive: json["time_arrive"] == null ? null : DateTime.parse(json["time_arrive"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vat": vat,
    "time_arrive": timeArrive?.toIso8601String(),
  };
}
