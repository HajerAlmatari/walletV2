import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/provider/google_sign_in.dart';
import 'package:walletapp/screens/api.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'dashboard.dart';
import 'welcome.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context)=>GoogleSignInProvider(),

    child: MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            return NavScreen();
          } else {
            return WelcomePage();
          }
        },
      ),
    ),
  );
}