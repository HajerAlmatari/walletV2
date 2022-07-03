import 'package:flutter/material.dart';

import '../constants.dart';

class CardModel {
  String accountType;
  String cardNumber;
  String expDate;
  //String cvv;
  Color cardColor;

  CardModel({
    required this.accountType,
    required this.cardNumber,
    required this.expDate,
    //required this.cvv,
    required this.cardColor,
  });
}

List<CardModel> myCards =[
  CardModel(
      accountType: "Rial Yemeni",
      cardNumber: "**** **** **** 4321",
      expDate: "18/5/2022",
      //cvv: "**4",
      cardColor: Colors.redAccent
  ),
  CardModel(
      accountType: "Rial Saudi",
      cardNumber: "**** **** **** 1234",
      expDate: "18/5/2021",
      //cvv: "**1",
      cardColor: Colors.green
  ),
  CardModel(
      accountType: "American Dollars",
      cardNumber: "**** **** **** 5555",
      expDate: "18/5/2023",
      //cvv: "**5",
      cardColor:Colors.blue,
  ),
];