// To parse this JSON data, do
//
//     final orderAndNotificationCountModel = orderAndNotificationCountModelFromJson(jsonString);

import 'dart:convert';

OrderAndNotificationCountModel orderAndNotificationCountModelFromJson(String str) => OrderAndNotificationCountModel.fromJson(json.decode(str));

String orderAndNotificationCountModelToJson(OrderAndNotificationCountModel data) => json.encode(data.toJson());

class OrderAndNotificationCountModel {
    Data? data;
    String? message;
    int? code;

    OrderAndNotificationCountModel({
        this.data,
        this.message,
        this.code,
    });

    factory OrderAndNotificationCountModel.fromJson(Map<String, dynamic> json) => OrderAndNotificationCountModel(
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
    int? tripCount;
    int? notificationsCount;

    Data({
        this.tripCount,
        this.notificationsCount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        tripCount: json["tripCount"],
        notificationsCount: json["notificationsCount"],
    );

    Map<String, dynamic> toJson() => {
        "tripCount": tripCount,
        "notificationsCount": notificationsCount,
    };
}
