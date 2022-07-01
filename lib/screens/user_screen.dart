import 'package:flutter/material.dart';

import '../constants.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        centerTitle: true,
        backgroundColor: CDarkerColor,
      ),
      body:Container(
      alignment: Alignment.center,
        child: Image.asset("assets/icons/avatar_1.png"),)
    );
  }
}
