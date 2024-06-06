// To parse this JSON data, do
//
//     final searchTextModel = searchTextModelFromJson(jsonString);

import 'dart:convert';

SearchTextModel searchTextModelFromJson(String str) => SearchTextModel.fromJson(json.decode(str));

String searchTextModelToJson(SearchTextModel data) => json.encode(data.toJson());

class SearchTextModel {
    List<SearchTextResults>? results;
    String? status;

    SearchTextModel({
       
        this.results,
        this.status,
    });

    factory SearchTextModel.fromJson(Map<String, dynamic> json) => SearchTextModel(
       results: json["results"] == null ? [] : List<SearchTextResults>.from(json["results"]!.map((x) => SearchTextResults.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
      "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
    };
}

class SearchTextResults {
    String? formattedAddress;
    Geometry? geometry;
  
  
    String? name;
 

    SearchTextResults({
        this.formattedAddress,
        this.geometry,
   
        this.name,
     
    });

    factory SearchTextResults.fromJson(Map<String, dynamic> json) => SearchTextResults(
        formattedAddress: json["formatted_address"],
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
        name: json["name"],
        );

    Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress,
        "geometry": geometry?.toJson(),
        "name": name,
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
