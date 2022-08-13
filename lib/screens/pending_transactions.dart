import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:walletapp/Api/RemoteService.dart';
import 'package:walletapp/Models/SaveAccount.dart';
import 'package:walletapp/Models/transactions.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'package:walletapp/widgets/showSnackBar.dart';

class PendingTransactions extends StatefulWidget {
  const PendingTransactions({Key? key}) : super(key: key);

  @override
  _PendingTransactionsState createState() => _PendingTransactionsState();
}

class _PendingTransactionsState extends State<PendingTransactions> {
  List<Transactions>? transactionsList;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    SaveAccount obj = new SaveAccount();
    print("I'm in the Second" + obj.getId().toString());

    getData(obj.getId());
  }

  getData(int accountId) async {
    transactionsList = await RemoteService().getPendingTransactions(accountId);

    if (transactionsList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    postData(int transactionId) async {
      var response = await http.post(
        Uri.parse(
            'https://walletv1.azurewebsites.net/api/Cancle/cancleprocess?id='+transactionId.toString()),
        // body: jsonEncode({
        //   "id": transactionId,
        // }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("SuccessFully");

        EasyLoading.showSuccess("Transaction Canceled Successfully",duration: Duration(milliseconds: 500));

        await Future.delayed(Duration(milliseconds: 1000));

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            NavScreen()), (Route<dynamic> route) => false);
        //
        //
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

      } else {
        EasyLoading.showError(response.body,duration: Duration(milliseconds: 500));

        print("Not SuccessFully");
        print(response.body);
        print("Transaction Id $transactionId");
        // print(response.statusCode);
      }
      // print(response.body);
    }




    return Scaffold(
      appBar: AppBar(
        backgroundColor:                     Color.fromRGBO(39, 138, 189, 1)
        ,
        centerTitle: true,
        title: Text("Pending Transactions",style: TextStyle(color: Colors.white),),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: transactionsList?.length == 0
            ? Center(
          child: Text("you have'nt any pending trnsactions "),
        )
            : ListView.builder(
          itemCount: transactionsList?.length,
          itemBuilder: (context, index) {
            print("Items Count${transactionsList?.length}");

            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        (transactionsList![index].startdate).toString().substring(0,19),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    tileColor: Color.fromRGBO(39, 138, 189, 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Amount : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            Text(
                              (transactionsList![index].amount)
                                  .toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Description : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Text(
                            (transactionsList![index].description)
                                .toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Cancel Transaction'),
                              content: const Text('Are you sure to cancel the Transaction?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: (){
EasyLoading.show();
                                    postData(transactionsList![index].id);

                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),

                              ],
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.redAccent,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 20),
                          padding: EdgeInsets.all(8),
                          child: Text("Cancle",style: TextStyle(color: Colors.white),),
                        )
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
