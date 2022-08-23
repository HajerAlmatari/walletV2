import 'package:flutter/material.dart';
import 'package:walletapp/screens/transaction_card.dart';

import '../constants.dart';
import '../data/transaction_data.dart';
import '../widgets/drawer.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Wallet"),
    centerTitle: true,
    backgroundColor: CDarkerColor,
    leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: ()=>Navigator.of(context).pop(),
    )),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        height: 400,
        child: ListView.separated(itemBuilder: (context, index) {
          return TransactionCard(
              transactionModel: myTransactions[index]);
        }, separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        }, itemCount: myTransactions.length),
      ),
    );
  }
}
