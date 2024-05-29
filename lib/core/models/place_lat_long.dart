// To parse this JSON data, do
//
//     final getPlaceLatLongModel = getPlaceLatLongModelFromJson(jsonString);

import 'dart:convert';

GetPlaceLatLongModel getPlaceLatLongModelFromJson(String str) => GetPlaceLatLongModel.fromJson(json.decode(str));

String getPlaceLatLongModelToJson(GetPlaceLatLongModel data) => json.encode(data.toJson());

class GetPlaceLatLongModel {
    Result? result;
    String? status;

    GetPlaceLatLongModel({
        this.result,
        this.status,
    });

    factory GetPlaceLatLongModel.fromJson(Map<String, dynamic> json) => GetPlaceLatLongModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "status": status,
    };
}

class Result {
    Geometry? geometry;

    Result({
        this.geometry,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
    };
}

class Geometry {
    Location? location;

    Geometry({
        this.location,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
    };
}

class Location {
    double? lat;
    double? lng;

    Location({
        this.lat,
        this.lng,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}

