import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:walletapp/Models/ClientDetails.dart';
import 'package:walletapp/Models/SaveAccount.dart';
import 'package:walletapp/Models/SaveClientDetails.dart';
import 'package:walletapp/screens/transactions-history.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';
import 'package:http/http.dart' as http;


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
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();

  List<SubAccount>? subAccountsList;

  SaveClientDetails clientDetailsObj = SaveClientDetails();
  SaveAccount obj = SaveAccount();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("I'm in the Second" + obj.getId().toString());

    print(Uri.parse('https://walletv1.azurewebsites.net/api/SubAccount/getClientDetails?accountId='+obj.getId().toString()));


    getSubAccounts(obj.getId());
    // getSubAccounts(obj.getId());


    print("Client Last Name From Nav Screen " + clientDetailsObj.getLastName().toString());



    print("Hello From Nav Screen");
   print("I'm in the Second From Nav Screen" + obj.getId().toString());



    print("100078729-YR".substring(0, "100078729-YR".indexOf('-')));


  }

  getSubAccounts(int accountId) async {
    print("Get Sub Accounts From Nav Screen");
    var response = await RemoteService().getAllSubAccount(accountId);
    subAccountsList = response;
    SubAccountNumbers subAccountNumbers = new SubAccountNumbers();
    subAccountNumbers.setSubAccountList(subAccountsList!);

    print("Sub Account List From Nav Screen : "+subAccountNumbers.getSubAccountList());

    if (subAccountsList != null) {
      for (int i = 0; i < subAccountsList!.length; i++) {
        print(subAccountsList?.elementAt(i).id);
      }
    }
  }


  getClientDetails(int accountId) async {
    try {
      var response = await http.get(Uri.parse('https://walletv1.azurewebsites.net/api/SubAccount/getClientDetails?accountId='+accountId.toString()),);

      print("Status Code ${response.statusCode}");
      print("Response Body ${response.body}");

      if (response.statusCode == 200) {
        var json = response.body;
        ClientDetails clientDetails = clientDetailsFromJson(json);

        print("SuccessFully");

        clientDetailsObj.setEmail(clientDetails.email.toString());
        clientDetailsObj.setFirstName(clientDetails.clientFirstName.toString());
        clientDetailsObj.setLastName(clientDetails.clientLastName.toString());


        print("clientDetailsObj.setLastName  "+clientDetailsObj.getLastName());
        print("Client First Name From getClientDetails   "+clientDetailsObj.getFirstName());
        print("Client Email From getClientDetails   "+clientDetailsObj.getEmail());







        // showSnackBar(context, "Successfully Logged in");


      } else {
        return "";
      }
    } catch (error) {
      print(error.toString());
      return(error.toString());
    }
  }




  int _selectedIndex = 0;
  static TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const TabBarView(
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

    getClientDetails(obj.getId());

    setState((){
      //
      // WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   ShowCaseWidget.of(context).startShowCase([_key1]);
      // });

      // ShowCaseWidget.of(context).startShowCase([_key1]);
    });
    void _onPress() {
      print('I am pressed');
    }
    // final user = context.read<FirebaseAuthMethods>().user;
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          drawer: NavigationDrawer(clientDetailsObj.getFirstName(), clientDetailsObj.getLastName(), clientDetailsObj.getEmail(), ),
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {
                setState((){

                  ShowCaseWidget.of(context).startShowCase([_key1,_key2]);


                  //
                    // WidgetsBinding.instance.addPostFrameCallback((_) async {
                    //   ShowCaseWidget.of(context).startShowCase([_key1]);
                    // });

                  // ShowCaseWidget.of(context).startShowCase([_key1]);
                });
              }, icon: IconButton(icon: Icon(Icons.help), onPressed: () { print("clientDetailsObj.getLastName() from app bar  "+clientDetailsObj.getLastName().toString()); },), ),
            ],
            title: Text("YCB Wallet"),
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
          body: Container(
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
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Showcase(
                  overlayPadding: const EdgeInsets.all(8),
                  contentPadding: const EdgeInsets.all(20),
                  key: _key1,
                  description: "Show all Your Transactions History",
                  showcaseBackgroundColor: CDarkerColor,
                  descTextStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                  child: const Icon(Icons.book_online_outlined),
                ),
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
