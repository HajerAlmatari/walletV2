// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.code,
    required this.message,
    required this.accountId,
  });

  int code;
  String message;
  List<int> accountId;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    code: json["code"],
    message: json["message"],
    accountId: List<int>.from(json["accountId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "accountId": List<dynamic>.from(accountId.map((x) => x)),
  };
}
