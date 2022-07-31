import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';

import '../constants.dart';
import '../main.dart';
import '../services/google_sign_in.dart';
import '../screens/nav_screen.dart';
import '../screens/setting.dart';
import '../screens/user_screen.dart';

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

class NavigationDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
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
      color: Color.fromRGBO(120, 148, 150, 0.8),
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
              children: const [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage("assets/icons/avatar_1.png"),
                  // backgroundImage: Image.network(user!.photoURL.toString()).image,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                    // user.displayName!.toString(),
                  "User Name",
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                Text(
                    // user.email!.toString(),
                  "User Email",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              ],
            )),
      ));

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            // ListTile(
            //   leading: Icon(Icons.dashboard),
            //   title: Text("DASHBOARD"),
            //   onTap: (){
            //     Navigator.pop(context);
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) =>
            //       const DashboardScreen()
            //       ));},
            // ),
            ListTile(
              leading: Icon(Icons.wallet_giftcard),
              title: Text("Wallet"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const NavScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text("MESSAGES"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("UTILITY BILLS"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text("FUNDS TRANSFER"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.house_siding),
              title: Text("BRANCHES"),
              onTap: () {},
            ),
            const Divider(
              color: Colors.black26,
            ),
            ListTile(
              leading: Icon(Icons.design_services_rounded),
              title: Text("SERVICES"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("PROFILE"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
             onTap: (){
               //
               // final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
               // provider.googleLogOut();
               // FirebaseAuth.instance.signOut();
               // // user.delete();


               context.read<FirebaseAuthMethods>().signOut(context);

               print("logout");
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => AuthWrapper()),
               );
             },
            ),
          ],
        ),
      );
}
