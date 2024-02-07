// To parse this JSON data, do
//
//     final driverDataModel = driverDataModelFromJson(jsonString);

import 'dart:convert';

DriverDataModel driverDataModelFromJson(String str) => DriverDataModel.fromJson(json.decode(str));

String driverDataModelToJson(DriverDataModel data) => json.encode(data.toJson());

class DriverDataModel {
  Data? data;
  String? message;
  int? code;

  DriverDataModel({
    this.data,
    this.message,
    this.code,
  });

  factory DriverDataModel.fromJson(Map<String, dynamic> json) => DriverDataModel(
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
  int? driverStatus;
  DriverDetails? driverDetails;
  List<DriverDocument>? driverDocuments;

  Data({
    this.driverStatus,
    this.driverDetails,
    this.driverDocuments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    driverStatus: json["driver_status"],
    driverDetails: json["driver_details"] == null ? null : DriverDetails.fromJson(json["driver_details"]),
    driverDocuments: json["driver_documents"] == null ? [] : List<DriverDocument>.from(json["driver_documents"]!.map((x) => DriverDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "driver_status": driverStatus,
    "driver_details": driverDetails?.toJson(),
    "driver_documents": driverDocuments == null ? [] : List<dynamic>.from(driverDocuments!.map((x) => x.toJson())),
  };
}

class DriverDetails {
  int? id;
  String? bikeType;
  String? bikeModel;
  String? bikeColor;
  int? areaId;

  DriverDetails({
    this.id,
    this.bikeType,
    this.bikeModel,
    this.bikeColor,
    this.areaId,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
    id: json["id"],
    bikeType: json["bike_type"],
    bikeModel: json["bike_model"],
    bikeColor: json["bike_color"],
    areaId: json["area_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bike_type": bikeType,
    "bike_model": bikeModel,
    "bike_color": bikeColor,
    "area_id": areaId,
  };
}

class DriverDocument {
  int? id;
  String? agencyNumber;
  String? bikeLicense;
  String? idCard;
  String? houseCard;
  String? bikeImage;

  DriverDocument({
    this.id,
    this.agencyNumber,
    this.bikeLicense,
    this.idCard,
    this.houseCard,
    this.bikeImage,
  });

  factory DriverDocument.fromJson(Map<String, dynamic> json) => DriverDocument(
    id: json["id"],
    agencyNumber: json["agency_number"],
    bikeLicense: json["bike_license"],
    idCard: json["id_card"],
    houseCard: json["house_card"],
    bikeImage: json["bike_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "agency_number": agencyNumber,
    "bike_license": bikeLicense,
    "id_card": idCard,
    "house_card": houseCard,
    "bike_image": bikeImage,
  };
}
