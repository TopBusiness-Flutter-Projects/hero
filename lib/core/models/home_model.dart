// // To parse this JSON data, do
// //
// //     final homeModel = homeModelFromJson(jsonString);
//
// import 'dart:convert';
//
// HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));
//
// String homeModelToJson(HomeModel data) => json.encode(data.toJson());
//
// class HomeModel {
//   final Data? data;
//   final String? message;
//   final int? code;
//
//   HomeModel({
//     this.data,
//     this.message,
//     this.code,
//   });
//
//   factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     message: json["message"],
//     code: json["code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data?.toJson(),
//     "message": message,
//     "code": code,
//   };
// }
//
// class Data {
//   final List<SliderModel>? sliders;
//   final List<NewTrip>? newTrips;
//   final User? user;
//
//   Data({
//     this.sliders,
//     this.newTrips,
//     this.user,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     sliders: json["sliders"] == null ? [] : List<SliderModel>.from(json["sliders"]!.map((x) => SliderModel.fromJson(x))),
//     newTrips: json["new_trips"] == null ? [] : List<NewTrip>.from(json["new_trips"]!.map((x) => NewTrip.fromJson(x))),
//     user: json["user"] == null ? null : User.fromJson(json["user"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toJson())),
//     "new_trips": newTrips == null ? [] : List<dynamic>.from(newTrips!.map((x) => x.toJson())),
//     "user": user?.toJson(),
//   };
// }
//
// class NewTrip {
//   final int? id;
//   final String? type;
//   final String? tripType;
//   final String? fromAddress;
//   final String? fromLong;
//   final String? fromLat;
//   final String? toAddress;
//   final String? toLong;
//   final String? toLat;
//   final dynamic timeRide;
//   final dynamic timeArrive;
//   final dynamic distance;
//   final dynamic time;
//   final dynamic price;
//   final dynamic name;
//   final dynamic phone;
//   final int? userId;
//   final dynamic driverId;
//   final int? ended;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic deletedAt;
//
//   NewTrip({
//     this.id,
//     this.type,
//     this.tripType,
//     this.fromAddress,
//     this.fromLong,
//     this.fromLat,
//     this.toAddress,
//     this.toLong,
//     this.toLat,
//     this.timeRide,
//     this.timeArrive,
//     this.distance,
//     this.time,
//     this.price,
//     this.name,
//     this.phone,
//     this.userId,
//     this.driverId,
//     this.ended,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//
//   factory NewTrip.fromJson(Map<String, dynamic> json) => NewTrip(
//     id: json["id"],
//     type: json["type"],
//     tripType: json["trip_type"],
//     fromAddress: json["from_address"],
//     fromLong: json["from_long"],
//     fromLat: json["from_lat"],
//     toAddress: json["to_address"],
//     toLong: json["to_long"],
//     toLat: json["to_lat"],
//     timeRide: json["time_ride"],
//     timeArrive: json["time_arrive"],
//     distance: json["distance"],
//     time: json["time"],
//     price: json["price"],
//     name: json["name"],
//     phone: json["phone"],
//     userId: json["user_id"],
//     driverId: json["driver_id"],
//     ended: json["ended"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     deletedAt: json["deleted_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "type": type,
//     "trip_type": tripType,
//     "from_address": fromAddress,
//     "from_long": fromLong,
//     "from_lat": fromLat,
//     "to_address": toAddress,
//     "to_long": toLong,
//     "to_lat": toLat,
//     "time_ride": timeRide,
//     "time_arrive": timeArrive,
//     "distance": distance,
//     "time": time,
//     "price": price,
//     "name": name,
//     "phone": phone,
//     "user_id": userId,
//     "driver_id": driverId,
//     "ended": ended,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "deleted_at": deletedAt,
//   };
// }
//
// class SliderModel {
//   final String? image;
//   final String? link;
//
//   SliderModel({
//     this.image,
//     this.link,
//   });
//
//   factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
//     image: json["image"],
//     link: json["link"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "image": image,
//     "link": link,
//   };
// }
//
// class User {
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? image;
//   final DateTime? birth;
//   final String? type;
//   final String? status;
//   final String? token;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//     this.birth,
//     this.type,
//     this.status,
//     this.token,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     image: json["image"],
//     birth: json["birth"] == null ? null : DateTime.parse(json["birth"]),
//     type: json["type"],
//     status: json["status"],
//     token: json["token"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "image": image,
//     "birth": "${birth!.year.toString().padLeft(4, '0')}-${birth!.month.toString().padLeft(2, '0')}-${birth!.day.toString().padLeft(2, '0')}",
//     "type": type,
//     "status": status,
//     "token": token,
//     "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
//     "updated_at": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
//   };
// }


// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final Data? data;
  final String? message;
  final int? code;

  HomeModel({
    this.data,
    this.message,
    this.code,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  final List<SliderModel>? sliders;
  final List<NewTrip>? newTrips;
  final User? user;

  Data({
    this.sliders,
    this.newTrips,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sliders: json["sliders"] == null ? [] : List<SliderModel>.from(json["sliders"]!.map((x) => SliderModel.fromJson(x))),
    newTrips: json["new_trips"] == null ? [] : List<NewTrip>.from(json["new_trips"]!.map((x) => NewTrip.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toJson())),
    "new_trips": newTrips == null ? [] : List<dynamic>.from(newTrips!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

class NewTrip {
  final int? id;
  final String? type;
  final String? tripType;
  final String? fromAddress;
  final String? fromLong;
  final String? fromLat;
  final String? toAddress;
  final String? toLong;
  final String? toLat;
  final dynamic timeRide;
  final dynamic timeArrive;
  final dynamic distance;
  final dynamic time;
  final dynamic price;
  final dynamic name;
  final dynamic phone;
  final User? user;
  final dynamic driver;
  final String? createdAt;
  final String? updatedAt;

  NewTrip({
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

  factory NewTrip.fromJson(Map<String, dynamic> json) => NewTrip(
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
    timeArrive: json["time_arrive"],
    distance: json["distance"],
    time: json["time"],
    price: json["price"],
    name: json["name"],
    phone: json["phone"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    driver: json["driver"],
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
    "time_arrive": timeArrive,
    "distance": distance,
    "time": time,
    "price": price,
    "name": name,
    "phone": phone,
    "user": user?.toJson(),
    "driver": driver,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final DateTime? birth;
  final String? type;
  final String? status;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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

class SliderModel {
  final String? image;
  final String? link;

  SliderModel({
    this.image,
    this.link,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    image: json["image"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "link": link,
  };
}
