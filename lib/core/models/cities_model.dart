// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) => CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  List<Datum>? data;
  String? message;
  int? code;

  CitiesModel({
    this.data,
    this.message,
    this.code,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class Datum {
  int? id;
  String? name;
  List<Area>? areas;

  Datum({
    this.id,
    this.name,
    this.areas,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    areas: json["areas"] == null ? [] : List<Area>.from(json["areas"]!.map((x) => Area.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "areas": areas == null ? [] : List<dynamic>.from(areas!.map((x) => x.toJson())),
  };
}

class Area {
  int? id;
  String? name;
  int? cityId;
  String? cityName;

  Area({
    this.id,
    this.name,
    this.cityId,
    this.cityName,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"],
    name: json["name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city_id": cityId,
    "city_name": cityName,
  };
}
