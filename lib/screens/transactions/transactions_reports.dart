import 'package:flutter/material.dart';

import '../../data/transaction_data.dart';
import '../transaction_card.dart';

class TransactionsReportsPage extends StatelessWidget {
  const TransactionsReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      child: Column(
    children: [
      const SizedBox(
        height: 30,
      ),
      const Text(
        "Transactions History",
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black45),
      ),
      const SizedBox(
        height: 15,
      ),
       SizedBox(
        height: MediaQuery.of(context).size.height *.8,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return TransactionCard(
                  transactionModel: myTransactions[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: myTransactions.length),
      ),

    ]));
  }
}
