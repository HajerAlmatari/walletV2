import 'package:flutter/material.dart';

import '../../data/transaction_data.dart';
import '../transaction_card.dart';

class TransactionsReportsPage extends StatelessWidget {
  const TransactionsReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.0),
      child: Column(
    children: [
      SizedBox(
        height: 30,
      ),
      Text(
        "Transactions History",
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black45),
      ),
      SizedBox(
        height: 15,
      ),
      Container(
        height: MediaQuery.of(context).size.height *.8,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return TransactionCard(
                  transactionModel: myTransactions[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: myTransactions.length),
      ),

    ]));
  }
}
