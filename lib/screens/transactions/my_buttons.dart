import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walletapp/screens/transfer_to_other_account.dart';

import 'TestPage.dart';

class MyButton extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;
  final VoidCallback onTap;
  const MyButton({Key? key, required this.iconImagePath, required this.buttonText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Column(
        children: [
          //icon
          Container(
              height: 100,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 20,
                    spreadRadius: 2,

                  )]
              ),
              child: Center(
                child:SvgPicture.asset(iconImagePath,width: 60,),
              )
          ),
          const SizedBox(height: 12,),
          //text
          Text(buttonText, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[700]), textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
