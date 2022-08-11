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

  List<Transactions>? transactionsList;
  var isLoaded = false;


  @override
  void initState(){
    super.initState();

    SaveAccount obj = new SaveAccount();
    print("I'm in the Second"+ obj.getId().toString());

    getData(obj.getId());

  }

  getData(int accountId)async{
    transactionsList = await RemoteService().getTransactions(accountId);

    if(transactionsList != null){
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
          itemCount: transactionsList?.length,
          itemBuilder: (context,index){

          return Container(
            child: Column(
              children: <Widget>[
                Card(

                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10,20,10,20),
                    child: Column(
                      children: <Widget>[
                        Text(transactionsList![index].description),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },),
        replacement: const Center(
          child: Text("There isn't any transaction yet"),
        ),
      ),
    );
  }

}