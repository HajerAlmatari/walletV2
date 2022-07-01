import 'package:flutter/material.dart';
import '../data/transaction_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transactionModel;

  const TransactionCard({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black38)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 60,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: transactionModel.color,
                ),
                child: Image.asset(transactionModel.avatar),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionModel.name,
                    style: TextStyle(fontSize: 13, color: Colors.red),
                  ),
                  Text(
                    transactionModel.date,
                    style: TextStyle(fontSize: 10, color: Colors.green),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transactionModel.currentBalance,
                    style: TextStyle(fontSize: 13, color: Colors.red),
                  ),
                  Row(
                    children: [
                      transactionModel.changePrecentageIndicator == "up"?
                          Icon(FontAwesomeIcons.levelUpAlt,
                          size: 10,
                          color: Colors.green,):
                          Icon(FontAwesomeIcons.levelDownAlt,
                          size: 10,
                          color: Colors.red,),
                      SizedBox(height: 5,),
                      Text(transactionModel.changePrecentage, style: TextStyle(fontSize: 10),)
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
