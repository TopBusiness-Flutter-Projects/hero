// To parse this JSON data, do
//
//     final storeBikeDetailsModel = storeBikeDetailsModelFromJson(jsonString);

import 'dart:convert';

StoreBikeDetailsModel storeBikeDetailsModelFromJson(String str) => StoreBikeDetailsModel.fromJson(json.decode(str));

String storeBikeDetailsModelToJson(StoreBikeDetailsModel data) => json.encode(data.toJson());

class StoreBikeDetailsModel {
  Data? data;
  String? message;
  int? code;

  StoreBikeDetailsModel({
    this.data,
    this.message,
    this.code,
  });

  factory StoreBikeDetailsModel.fromJson(Map<String, dynamic> json) => StoreBikeDetailsModel(
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
  String? agencyNumber;
  String? bikeLicense;
  String? idCard;
  String? houseCard;
  String? bikeImage;
  bool? status;
  DriverDetails? driverDetails;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.agencyNumber,
    this.bikeLicense,
    this.idCard,
    this.houseCard,
    this.bikeImage,
    this.status,
    this.driverDetails,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    agencyNumber: json["agency_number"],
    bikeLicense: json["bike_license"],
    idCard: json["id_card"],
    houseCard: json["house_card"],
    bikeImage: json["bike_image"],
    status: json["status"],
    driverDetails: json["driver_details"] == null ? null : DriverDetails.fromJson(json["driver_details"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "agency_number": agencyNumber,
    "bike_license": bikeLicense,
    "id_card": idCard,
    "house_card": houseCard,
    "bike_image": bikeImage,
    "status": status,
    "driver_details": driverDetails?.toJson(),
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}

class DriverDetails {
  int? id;
  String? bikeType;
  String? bikeModel;
  String? bikeColor;
  Area? area;
  Driver? driver;
  DateTime? createdAt;
  DateTime? updatedAt;

  DriverDetails({
    this.id,
    this.bikeType,
    this.bikeModel,
    this.bikeColor,
    this.area,
    this.driver,
    this.createdAt,
    this.updatedAt,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
    id: json["id"],
    bikeType: json["bike_type"],
    bikeModel: json["bike_model"],
    bikeColor: json["bike_color"],
    area: json["area"] == null ? null : Area.fromJson(json["area"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bike_type": bikeType,
    "bike_model": bikeModel,
    "bike_color": bikeColor,
    "area": area?.toJson(),
    "driver": driver?.toJson(),
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
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
  DateTime? createdAt;
  DateTime? updatedAt;

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
    this.createdAt,
    this.updatedAt,
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
