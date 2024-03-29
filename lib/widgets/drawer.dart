import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/screens/transactions-history.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';

import '../constants.dart';
import '../main.dart';
import '../screens/nav_screen.dart';
import '../screens/setting.dart';
import '../screens/user_screen.dart';

/*
class DrawerWidget extends StatelessWidget {


  DrawerWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // final Currentuser = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        centerTitle: true,
        backgroundColor: CDarkerColor,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: NavigationDrawer()),
    );
  }
}
*/

class NavigationDrawer extends StatelessWidget {

  String firstName;
  String lastName;
  String email;


  NavigationDrawer(this.firstName, this.lastName, this.email);


  @override
  Widget build(BuildContext context) => Drawer(
        child: SizedBox(
          width: 50,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Material(
      color: const Color.fromRGBO(39, 138, 189, 1),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserPage()),
          );
        },
        child: Container(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 24,
            ),
            child: Column(
              children:  [
                // CircleAvatar(
                //   radius: 52,
                //   backgroundImage: AssetImage("assets/icons/avatar_1.png"),
                //   // backgroundImage: Image.network(user!.photoURL.toString()).image,
                // ),
                SizedBox(
                  height: 12,
                ),
                Text(
                    // user.displayName!.toString(),
                  firstName+" "+lastName,
                  style: TextStyle(fontSize: 28, color: Colors.white70),
                ),
                Text(
                    // user.email!.toString(),
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                )
              ],
            )),
      ));

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text("Account Transaction"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TransactionHistory()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("PROFILE"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
            ),
            const Divider(
              color: Colors.black26,
            ),
            ListTile(

              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
             onTap: (){
               context.read<FirebaseAuthMethods>().signOut(context);
               print("logout");
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => const AuthWrapper()),
               );
             },
            ),
          ],
        ),
      );

}
