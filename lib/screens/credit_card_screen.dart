import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:walletapp/screens/transactions/make_transaction.dart';
import '../Api/RemoteService.dart';
import '../Models/SaveAccount.dart';
import '../Models/SubAccount.dart';
import '../widgets/carousel.dart';
import '../widgets/my_card.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  List<SubAccount> subAccountsList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SaveAccount obj = SaveAccount();
    print("I'm in the Second      " + obj.getId().toString());

    getSubAccounts(obj.getId());

    setState((){

      currentIndex = 1;
    });
  }

  getSubAccounts(int accountId) async {
    var response = await RemoteService().getAllSubAccount(accountId);

    print("Response From Credit Card Screen $response");
    subAccountsList = response;

    // for (int i = 0; i < subAccountsList!.length; i++) {
    //   print(subAccountsList.elementAt(i));
    //   print(subAccountsList?.elementAt(i).id);
    // }
  }

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    setState((){

    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage("images/wallet-backgroud.png"),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    height: 250,
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          width: 400,
                          child: CarouselSlider(
                            options: CarouselOptions(
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.height,
                                onPageChanged: (position, _) {
                                  setState(() {
                                    currentIndex = position;
                                  });
                                }),
                            items: List.generate(
                                subAccountsList.length,
                                (index) => MyCard(
                                    subAccount:
                                        subAccountsList.elementAt(index))),
                          ),
                        ),
                        CarouselWidget(3, currentIndex),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Transactions",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   height: 290,
                  //   child: ListView.separated(
                  //       itemBuilder: (context, index) {
                  //         return TransactionCard(
                  //             transactionModel: myTransactions[index]);
                  //       },
                  //       separatorBuilder: (context, index) {
                  //         return SizedBox(height: 10);
                  //       },
                  //       itemCount: myTransactions.length),
                  // ),
                  MakeTransactionPage(),

                  //SizedBox(height: 2,),
                  // Container(
                  //   height: 50,
                  //     margin: const EdgeInsets.symmetric(vertical: .0),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       color: CDarkerColor,
                  //     ),
                  //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  //     width: 500,
                  //     child: ClipRRect(
                  //       //borderRadius: BorderRadius.circular(25),
                  //         child: TextButton(
                  //           onPressed: () {Navigator.push(context,
                  //             MaterialPageRoute(builder: (context) {return const TransactionsList();},),);},
                  //           child: Text(
                  //             "Show All Transactions",
                  //             style: TextStyle(color: CLighterColor),
                  //           ),
                  //         ))),
                ])),
          ),
        ),
      ),

    );
  }
}
