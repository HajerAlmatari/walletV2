import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/Models/SaveAccount.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';

import '../Api/RemoteService.dart';
import '../Models/SubAccount.dart';
import '../constants.dart';
import '../widgets/drawer.dart';
import 'credit_card_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  List<SubAccount>? subAccountsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SaveAccount obj = new SaveAccount();
    print("I'm in the Second"+ obj.getId().toString());

    getSubAccounts(obj.getId());
  }

  getSubAccounts(int accountId) async {
    var response = await RemoteService().getAllSubAccount(accountId);
    subAccountsList = response;

    if(subAccountsList!= null){
    for(int i= 0; i<subAccountsList!.length; i++){
      print(subAccountsList?.elementAt(i).id);
    }}
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          ],
          title: (!user.isAnonymous && user.phoneNumber == null)
              ? Text(user.email.toString())
              : const Text("Wallet"),
          centerTitle: true,
          backgroundColor: CDarkerColor,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: "Account Activity",
                icon: Icon(Icons.credit_card),
              ),
              //Tab(text: "Saving", icon: Icon(Icons.savings),),
            ],
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [CDarkerColor, CLighterColor],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            )),
          ),
        ),
        //drawer: const DrawerWidget(),
        body: TabBarView(
          children: [
            CreditCardScreen(),
            //SavingsScreen(),
          ],
        ),
      ),
    );
  }
}
