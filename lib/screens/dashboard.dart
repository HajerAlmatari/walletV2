import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        centerTitle: true,
        backgroundColor: CDarkerColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) =>
            //         // NavigationDrawer()
            //     ));
          },
        ),

        elevation: 0,
      ),
      // drawer:  NavigationDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget> [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Card(
                elevation: 3,
                color: kPrimaryBackgroundColor,
                shadowColor: kPrimaryBackgroundColor,
                child: Column(
                  children:[
                    Image.asset("assets/icons/avatar_1.png", alignment: Alignment.center,width: size.width *0.2,),
                    const Text("Hello There"),
                    Row(
                      children: const <Widget> [
                        Text("Last login : "),
                        Text("9:45 PM, 26/6/2022"),
                      ],
                    )

                  ],
                ),
              ),
            ),
            Column(),
            Column(),
          ],
        ),
      ),
    );
  }
}
