import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/Models/SaveAccount.dart';
import 'package:walletapp/screens/transactions-history.dart';
import 'package:walletapp/screens/transactions/bottom_navigation.dart';
import 'package:walletapp/screens/transfer_between_holder_accounts.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';

import '../Api/RemoteService.dart';
import '../Models/SubAccount.dart';
import '../Models/SubAccountNumbers.dart';
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
    print("I'm in the Second     "+ obj.getId().toString());

    getSubAccounts(obj.getId());
  }

  getSubAccounts(int accountId) async {

    print("Account Id From Nav Screen $accountId");

    var response = await RemoteService().getAllSubAccount(accountId);
    subAccountsList = response;

    print("Response From Nav Screen $response");


    SubAccountNumbers subAccountNumbers= new SubAccountNumbers();
    subAccountNumbers.setSubAccountList(subAccountsList!);


    if(subAccountsList!= null){
    for(int i= 0; i<subAccountsList!.length; i++){
      print(subAccountsList?.elementAt(i).id);
    }}
  }

  int  _selectedIndex = 0;
  static  TextStyle optionStyle =
  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
    TabBarView(
      children: [
        CreditCardScreen(),
        //SavingsScreen(),
      ],
    ),

    // Text(
    //   'Transactions Page',
    //   style: optionStyle,
    // ),

    TransactionHistory(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            IconButton(onPressed: () {}, icon: Icon(Icons.question_mark_rounded))
          ],
          title:Text("User Name"),
          centerTitle: true,
          backgroundColor: CDarkerColor,
          // bottom: const TabBar(
          //   indicatorColor: Colors.white,
          //   indicatorWeight: 5,
          //   tabs: [
          //     Tab(
          //       text: "Account Activity",
          //       icon: Icon(Icons.credit_card),
          //     ),
          //     //Tab(text: "Saving", icon: Icon(Icons.savings),),
          //   ],
          // ),
          // elevation: 0,
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //       gradient: LinearGradient(
          //     colors: [CDarkerColor, CLighterColor],
          //     begin: Alignment.bottomRight,
          //     end: Alignment.topLeft,
          //   )),
          // ),
        ),
        //drawer: const DrawerWidget(),
        body:Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        /*
        const TabBarView(
          children: [f
            CreditCardScreen(),
            //SavingsScreen(),
          ],
        ),

         */
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online_outlined),
              label: 'Transactions History',
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
