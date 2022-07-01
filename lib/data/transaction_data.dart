import 'package:flutter/material.dart';

class TransactionModel {
  String name;
  String avatar;
  String currentBalance;
  String date;
  String changePrecentageIndicator;
  String changePrecentage;
  Color color;

  TransactionModel({
    required this.name,
    required this.changePrecentage,
    required this.changePrecentageIndicator,
    required this.avatar,
    required this.color,
    required this.currentBalance,
    required this.date,
});
}

List<TransactionModel> myTransactions =[
  TransactionModel(
      name: "Chris Pine",
      changePrecentage: "4.54%",
      changePrecentageIndicator: "down",
      avatar: "assets/icons/avatar_1.png",
      color: Colors.orange,
      currentBalance: "\$4253",
      date: "Jan 25th"
  ),
  TransactionModel(
      name: "Katy Perry",
      changePrecentage: "3.5%",
      changePrecentageIndicator: "up",
      avatar: "assets/icons/avatar_2.jpg",
      color: Colors.red,
      currentBalance: "\$3253",
      date: "Mar 25th"
  ),
  TransactionModel(
      name: "Dakota Johnson",
      changePrecentage: "1.5%",
      changePrecentageIndicator: "down",
      avatar: "assets/icons/avatar_3.png",
      color: Colors.green,
      currentBalance: "\$2253",
      date: "Jun 25th"
  ),
  TransactionModel(
      name: "Emily Blunt",
      changePrecentage: "1.5%",
      changePrecentageIndicator: "up",
      avatar: "assets/icons/avatar_4.jpg",
      color: Colors.green,
      currentBalance: "\$2253",
      date: "Jun 25th"
  ),
];