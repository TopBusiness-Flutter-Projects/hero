// To parse this JSON data, do
//
//     final zainCashModel = zainCashModelFromJson(jsonString);

import 'dart:convert';

ZainCashModel zainCashModelFromJson(String str) => ZainCashModel.fromJson(json.decode(str));

String zainCashModelToJson(ZainCashModel data) => json.encode(data.toJson());

class ZainCashModel {
   
    ProcessingTransaction? processingTransaction;

    ZainCashModel({
       
        this.processingTransaction,
    });

    factory ZainCashModel.fromJson(Map<String, dynamic> json) => ZainCashModel(
      
        processingTransaction: json["processingTransaction"] == null ? null : ProcessingTransaction.fromJson(json["processingTransaction"]),
    );

    Map<String, dynamic> toJson() => {
      
        "processingTransaction": processingTransaction?.toJson(),
    };
}


class ProcessingTransaction {
    int? success;
    String? transactionid;
    String? initialAmount;
    int? totalFees;
    String? total;

    ProcessingTransaction({
        this.success,
        this.transactionid,
        this.initialAmount,
        this.totalFees,
        this.total,
    });

    factory ProcessingTransaction.fromJson(Map<String, dynamic> json) => ProcessingTransaction(
        success: json["success"],
        transactionid: json["transactionid"],
        initialAmount: json["initialAmount"],
        totalFees: json["totalFees"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "transactionid": transactionid,
        "initialAmount": initialAmount,
        "totalFees": totalFees,
        "total": total,
    };
}
