import 'package:flutter/material.dart';
import 'package:walletapp/screens/transactions/my_buttons.dart';

class MakeTransactionPage extends StatelessWidget {
  const MakeTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              MyButton(iconImagePath: "assets/icons/avatar_1.png", buttonText: "Send"),
              MyButton(iconImagePath: "assets/icons/avatar_1.png", buttonText: "Send"),
              MyButton(iconImagePath: "assets/icons/avatar_1.png", buttonText: "Send"),
            ]
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              MyButton(iconImagePath: "assets/icons/avatar_1.png", buttonText: "Send"),
              MyButton(iconImagePath: "assets/icons/avatar_1.png", buttonText: "Send"),
              MyButton(iconImagePath: "assets/icons/avatar_1.png", buttonText: "Send"),
            ],
          )
        ],
      ),
    );
  }
}
