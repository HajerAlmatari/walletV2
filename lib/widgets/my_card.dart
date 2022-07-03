import 'package:flutter/material.dart';
import '../data/card_data.dart';
import 'carousel.dart';

class MyCard extends StatelessWidget {
  final CardModel card;
  const MyCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Container(
              width: 350,
              height: 170,
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Stack(
                  children: [
                    InkWell(
                      onTap:(){} ,
                    ),
                    Container(
                    padding: const EdgeInsets.all(20),
                    height: 250,
                    width: 350,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [card.cardColor, Color.fromRGBO(120, 148, 150, 0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CARD TYPE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Text(card.accountType, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),)
                              ],
                            ),
                            Column(
                              children: [
                            Text("CARD Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Text(card.cardNumber, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                            ]),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("EXP DATE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                    Text(card.expDate, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ]),

              ),

            );

  }
}
