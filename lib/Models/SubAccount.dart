// To parse this JSON data, do
//
//     final subAccount = subAccountFromJson(jsonString);

import 'dart:convert';

List<SubAccount> subAccountFromJson(String str) => List<SubAccount>.from(json.decode(str).map((x) => SubAccount.fromJson(x)));

String subAccountToJson(List<SubAccount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubAccount {
  SubAccount({
    required this.id,
    required this.currencyType,
    required this.credit,
    required this.debit,
    required this.status,
    required this.description,
    required this.creationDate,
    required this.activationDate,
    required this.lastModifiedDate,
    required this.accountId,
  });

  int id;
  String currencyType;
  dynamic credit;
  dynamic debit;
  int status;
  dynamic description;
  DateTime creationDate;
  dynamic activationDate;
  dynamic lastModifiedDate;
  int accountId;


  factory SubAccount.fromJson(Map<String, dynamic> json) => SubAccount(
        id: json["id"],
        currencyType: json["currencyType"],
        credit: json["credit"],
        debit: json["debit"],
        status: json["status"],
        description: json["description"],
        creationDate: DateTime.parse(json["creationDate"]),
        activationDate: json["activationDate"],
        lastModifiedDate: json["lastModifiedDate"],
        accountId: json["accountId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currencyType": currencyType,
        "credit": credit,
        "debit": debit,
        "status": status,
        "description": description,
        "creationDate": creationDate.toIso8601String(),
        "activationDate": activationDate,
        "lastModifiedDate": lastModifiedDate,
        "accountId": accountId,
      };
}
