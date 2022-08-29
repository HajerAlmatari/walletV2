import 'package:flutter/material.dart';
import 'package:walletapp/Api/RemoteService.dart';
import 'package:walletapp/Models/SaveAccount.dart';
import 'package:walletapp/Models/SaveClientDetails.dart';
import 'package:walletapp/Models/transactions.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<Transactions>? transactionsList;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    SaveAccount obj = SaveAccount();
    print("I'm in the Second" + obj.getId().toString());

    getData(obj.getId());

    SaveClientDetails ssobj = SaveClientDetails();

    print("Client Last Name From History Screen " + ssobj.getLastName().toString());

  }

  getData(int accountId) async {
    transactionsList = await RemoteService().getTransactions(accountId);

    if (transactionsList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: transactionsList?.length == 0
            ? const Center(
                child: Text("you have'nt any trnsaction yet"),
              )
            : ListView.builder(
                itemCount: transactionsList?.length,
                itemBuilder: (context, index) {
                  print("Items Count${transactionsList?.length}");

                  return Card(
                    margin: const EdgeInsets.all(10),
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
                          tileColor: const Color.fromRGBO(39, 138, 189, 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
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
                              const Text(
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

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Status : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                child: Text(
                                  (transactionsList![index].status)==0 ? "Pending" : "Completed" ,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );

                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              (transactionsList![index].startdate).toString(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text("Description : " +
                              transactionsList![index].description),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                        //   child: Column(
                        //     children: <Row>[
                        //       Row(
                        //         children: <Widget>[
                        //           Text("Description : "),
                        //           Text(transactionsList![index].description),
                        //         ],
                        //       ),
                        //       Row(),
                        //     ],
                        //   )
                        // ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
