// To parse this JSON data, do
//
//     final sendWhatsAppMsgResponseModel = sendWhatsAppMsgResponseModelFromJson(jsonString);

import 'dart:convert';

SendWhatsAppMsgResponseModel sendWhatsAppMsgResponseModelFromJson(String str) => SendWhatsAppMsgResponseModel.fromJson(json.decode(str));

String sendWhatsAppMsgResponseModelToJson(SendWhatsAppMsgResponseModel data) => json.encode(data.toJson());

class SendWhatsAppMsgResponseModel {
    bool? status;
    String? message;
    int? code;

    SendWhatsAppMsgResponseModel({
        this.status,
        this.message,
        this.code,
    });

    factory SendWhatsAppMsgResponseModel.fromJson(Map<String, dynamic> json) => SendWhatsAppMsgResponseModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
    };
}
