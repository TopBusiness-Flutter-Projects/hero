// To parse this JSON data, do
//
//     final getPlacesModel = getPlacesModelFromJson(jsonString);

import 'dart:convert';

GetPlacesModel getPlacesModelFromJson(String str) => GetPlacesModel.fromJson(json.decode(str));

String getPlacesModelToJson(GetPlacesModel data) => json.encode(data.toJson());

class GetPlacesModel {
    List<Prediction>? predictions;
    String? status;

    GetPlacesModel({
        this.predictions,
        this.status,
    });

    factory GetPlacesModel.fromJson(Map<String, dynamic> json) => GetPlacesModel(
        predictions: json["predictions"] == null ? [] : List<Prediction>.from(json["predictions"]!.map((x) => Prediction.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "predictions": predictions == null ? [] : List<dynamic>.from(predictions!.map((x) => x.toJson())),
        "status": status,
    };
}

class Prediction {
    String? description;
    
    String? placeId;
   
    Prediction({
        this.description,
       
        this.placeId,
     
    });

    factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        description: json["description"],
        placeId: json["place_id"],
        );

    Map<String, dynamic> toJson() => {
        "description": description,
        "place_id": placeId,
        };
}

