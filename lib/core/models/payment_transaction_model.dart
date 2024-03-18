// To parse this JSON data, do
//
//     final payTransactionModel = payTransactionModelFromJson(jsonString);

import 'dart:convert';

PayTransactionModel payTransactionModelFromJson(String str) => PayTransactionModel.fromJson(json.decode(str));

String payTransactionModelToJson(PayTransactionModel data) => json.encode(data.toJson());

class PayTransactionModel {
    Pay? pay;
    PayTransactionModel({
        this.pay,
    });
    factory PayTransactionModel.fromJson(Map<String, dynamic> json) => PayTransactionModel(
        pay: json["pay"] == null ? null : Pay.fromJson(json["pay"]),
    );

    Map<String, dynamic> toJson() => {
        "pay": pay?.toJson(),
    };
}

class Pay {
    int? success;
   

    Pay({
        this.success,
       
    });

    factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        success: json["success"],
       
    );

    Map<String, dynamic> toJson() => {
        "success": success,
      
    };
}
