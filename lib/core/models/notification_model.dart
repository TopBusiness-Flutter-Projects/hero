// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  final List<NotificationData>? data;
  final String? message;
  final int? code;

  NotificationModel({
    this.data,
    this.message,
    this.code,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class NotificationData {
  final int? id;
  final dynamic userId;
  final String? title;
  final String? description;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  NotificationData({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
