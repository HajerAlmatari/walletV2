// To parse this JSON data, do
//
//     final clientDetails = clientDetailsFromJson(jsonString);

import 'dart:convert';

ClientDetails clientDetailsFromJson(String str) => ClientDetails.fromJson(json.decode(str));

String clientDetailsToJson(ClientDetails data) => json.encode(data.toJson());

class ClientDetails {
  ClientDetails({
    required this.code,
    required this.message,
    required this.clientFirstName,
    required this.clientLastName,
    required this.email,
  });

  dynamic code;
  dynamic message;
  dynamic clientFirstName;
  dynamic clientLastName;
  dynamic email;

  factory ClientDetails.fromJson(Map<dynamic, dynamic> json) => ClientDetails(
    code: json["code"],
    message: json["message"],
    clientFirstName: json["clientFristName"],
    clientLastName: json["clientLastName"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "clientFirstName": clientFirstName,
    "clientLastName": clientLastName,
    "email": email,
  };
}
