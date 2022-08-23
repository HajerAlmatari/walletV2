import 'package:flutter/material.dart';
import 'package:walletapp/screens/transactions/make_transaction.dart';
import 'package:walletapp/screens/transactions/transactions_reports.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List Pages = [
    const MakeTransactionPage(),
    const TransactionsReportsPage(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 2,
          items: const [
            BottomNavigationBarItem(
                label: "Make Transactions", icon: Icon(Icons.money)),
            BottomNavigationBarItem(
                label: "Transactions Reports", icon: Icon(Icons.report)),
          ],
        ),
      ),
    );
  }
}
