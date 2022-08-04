import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:walletapp/screens/transaction_card.dart';
import 'package:walletapp/screens/transactions/bank_services.dart';
import 'package:walletapp/screens/transactions/make_transaction.dart';
import 'package:walletapp/screens/transactions/my_buttons.dart';
import 'package:walletapp/screens/transactions_list.dart';

import '../../Api/RemoteService.dart';
import '../../Models/SaveAccount.dart';
import '../../Models/SubAccount.dart';
import '../../widgets/carousel.dart';
import '../../widgets/my_card.dart';

class ChangePotionState extends StatefulWidget {
  const ChangePotionState({Key? key}) : super(key: key);

  @override
  State<ChangePotionState> createState() => _ChangePotionStateState();
}

class _ChangePotionStateState extends State<ChangePotionState> {
  List<SubAccount> subAccountsList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SaveAccount obj = new SaveAccount();
    print("I'm in the Second" + obj.getId().toString());

    getSubAccounts(obj.getId());
  }

  getSubAccounts(int accountId) async {
    var response = await RemoteService().getAllSubAccount(accountId);
    subAccountsList = response;

    // for (int i = 0; i < subAccountsList!.length; i++) {
    //   print(subAccountsList.elementAt(i));
    //   print(subAccountsList?.elementAt(i).id);
    // }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 250,
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: 350,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: false,
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
                          // ListView.separated(
                          //   itemBuilder: (context, index) {
                          //     return MyCard(card: myCards[index]);
                          //   },
                          //   separatorBuilder: (context, index) {
                          //     return const SizedBox(
                          //       width: 10,
                          //     );
                          //   },
                          //   itemCount: myCards.length,
                          //   shrinkWrap: true,
                          //   primary: false,
                          //   scrollDirection: Axis.horizontal,
                          // ),
                        ),
                      ),
                      CarouselWidget(3, currentIndex),
                    ],
                  ),
                ),

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
              ])),
        ),
      ),

    );
  }
}
