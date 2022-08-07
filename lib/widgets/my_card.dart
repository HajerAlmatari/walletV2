import 'package:flutter/material.dart';
import 'package:walletapp/Models/SubAccount.dart';
import '../data/card_data.dart';
import 'carousel.dart';

class MyCard extends StatelessWidget {
  // final CardModel card;
  final SubAccount? subAccount;

  const MyCard({Key? key, required this.subAccount}) : super(key: key);

  get subAccountId => subAccount?.id.toString();

  get subAccountType => subAccount?.currencyType.toString();

  get credit => subAccount?.credit;

  get debit => subAccount?.debit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 170,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
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
                colors: [
                  Color.fromRGBO(39, 138, 189, 1),
                  Color.fromRGBO(98, 150, 177, 1),
                ],
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

                    Column(children: [
                      Text(
                        "Account Number",
                        style: TextStyle(
                            color: Color.fromRGBO(240, 240, 240, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        subAccountId,
                        style: TextStyle(
                            color: Color.fromRGBO(240, 240, 240, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          (debit - credit).toString() + " " + subAccountType,
                          style: TextStyle(
                            color: Color.fromRGBO(240, 240, 240, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXP DATE",
                              style: TextStyle(
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              "2015",
                              style: TextStyle(
                                  color: Color.fromRGBO(240, 240, 240, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
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
