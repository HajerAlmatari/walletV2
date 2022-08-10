import 'package:flutter/material.dart';
import 'package:walletapp/Api/RemoteService.dart';
import 'package:walletapp/Models/SaveAccount.dart';
import 'package:walletapp/Models/transactions.dart';

class TransactionHistory extends StatefulWidget{
  const TransactionHistory({Key? key}) : super (key: key);

  @override
  _TransactionHistoryState createState()=> _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>{

  List<Transactions>? transactionsHistoryList;
  var isLoaded = false;


  @override
  void initState(){
    super.initState();

    SaveAccount obj = new SaveAccount();
    print("I'm in the Second"+ obj.getId().toString());

    getData(obj.getId());

  }

  getData(int accountId)async{
    var TransactionHistory = await RemoteService().getTransactionsHistory(accountId);
    transactionsHistoryList = TransactionHistory;

    if(transactionsHistoryList!=null){
      setState((){
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: transactionsHistoryList?.length,
          itemBuilder: (context,index){

          return Container(
            child: Text("Hi"),
          );
        },),
        replacement: const Center(
          child: Text("There isn't any transaction yet"),
        ),
      ),
    );
  }

}