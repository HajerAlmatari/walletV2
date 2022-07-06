import 'package:flutter/material.dart';
import 'package:walletapp/Models/SubAccount.dart';
import '../data/card_data.dart';
import 'carousel.dart';

class MyCard extends StatelessWidget {
  // final CardModel card;
  final SubAccount? subAccount;

  const MyCard({Key? key, required this.subAccount}) : super(key: key);


get subAccountId =>subAccount?.id.toString();
get subAccountType =>subAccount?.currencyType.toString();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 170,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Stack(children: [
          InkWell(
            onTap: () {},
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 250,
            width: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.redAccent, Color.fromRGBO(120, 148, 150, 0.8)],
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
                        Text(
                          "CARD TYPE",
                          style: TextStyleLINK
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(subAccountType
                          ,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    Column(children: [
                      Text(
                        "CARD Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                       subAccountId,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ]),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXP DATE",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "2015",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            )
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
