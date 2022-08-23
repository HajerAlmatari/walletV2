// To parse this JSON data, do
//
//     final clientName = clientNameFromJson(jsonString);

import 'dart:convert';

ClientName clientNameFromJson(String str) => ClientName.fromJson(json.decode(str));

String clientNameToJson(ClientName data) => json.encode(data.toJson());

class ClientName {
  ClientName({
    required this.fullName,
  });

  String fullName;

  factory ClientName.fromJson(Map<String, dynamic> json) => ClientName(
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
  };
}
