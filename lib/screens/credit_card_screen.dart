import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:walletapp/screens/transaction_card.dart';
import 'package:walletapp/screens/transactions_list.dart';

import '../constants.dart';
import '../data/card_data.dart';
import '../data/transaction_data.dart';
import '../widgets/carousel.dart';
import '../widgets/my_card.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  int currentIndex= 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 250,
                            child: Column(
                              children: [
                                Container(
                                  height: 180,
                                  width: 350,
                                  child: CarouselSlider(options: CarouselOptions(
                                    autoPlay: false,
                                    aspectRatio: 2.0,
                                    enlargeCenterPage: true,
                                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    onPageChanged: (position,_) {
                                      setState(() {
                                        currentIndex = position;
                                      });
                                    }), items: List.generate(myCards.length, (index) => MyCard(card: myCards[index])),
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
                        Text("Transactions History", style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),),
                        SizedBox(height: 15,),
                        Container(
                          height: 290,
                          child: ListView.separated(itemBuilder: (context, index) {
                            return TransactionCard(
                                transactionModel: myTransactions[index]);
                          }, separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          }, itemCount: myTransactions.length),
                        ),
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
                        ])
              ),
            ),
        ),
        );
  }
}