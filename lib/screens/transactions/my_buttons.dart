import 'package:flutter/material.dart';

import 'TestPage.dart';

class MyButton extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;
  const MyButton({Key? key, required this.iconImagePath, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              const TestPage(),
          )),
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
                child:Image.asset(iconImagePath),
              )
          ),
          const SizedBox(height: 12,),
          //text
          Text(buttonText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),),
        ],
      ),
    );
  }
}
