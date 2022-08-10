// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

List<Transactions> transactionsHistoryFromJson(String str) =>
    List<Transactions>.from(json.decode(str).map((x) => Transactions.fromJson(x)));

String transactionsHistoryToJson(List<Transactions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transactions {
  Transactions({
    required this.id,
    required this.startdate,
    required this.type,
    required this.description,
    required this.status,
    required this.amount,
    required this.affectedId,
    required this.accountId,
    required this.servicePointId,
  });

  int id;
  DateTime startdate;
  int type;
  String description;
  int status;
  int amount;
  int affectedId;
  int accountId;
  int servicePointId;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        id: json["id"],
        startdate: DateTime.parse(json["startdate"]),
        type: json["type"],
        description: json["description"],
        status: json["status"],
        amount: json["amount"],
        affectedId: json["affectedId"],
        accountId: json["accountId"],
        servicePointId: json["servicePointId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startdate": startdate.toIso8601String(),
        "type": type,
        "description": description,
        "status": status,
        "amount": amount,
        "affectedId": affectedId,
        "accountId": accountId,
        "servicePointId": servicePointId,
      };
}
