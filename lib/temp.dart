// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:walletapp/home.dart';
// import 'package:walletapp/provider/google_sign_in.dart';
// import 'welcome.dart';
//
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//     create: (context)=>GoogleSignInProvider(),
//
//     child: MaterialApp(
//       routes: {
//         'welcome_screen' : (context)=>WelcomePage()
//       },
//
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
// // backgroundColor: Colors.lightBlueAccent
//       ),
//       home:  HomePage(),
//     ),
//   );
// }
//
//
//
//
//
//
//
//
//
// final navigatorKey = GlobalKey<NavigatorState>();
//
// MaterialApp(
// theme: ThemeData(scaffoldBackgroundColor: Colors.white),
// navigatorKey: navigatorKey,
// debugShowCheckedModeBanner: false,
// home: StreamBuilder(
// stream: FirebaseAuth.instance.authStateChanges(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const Center(child: CircularProgressIndicator());
// } else if (snapshot.hasError) {
// return const Center(child: Text('Something went wrong!'));
// } else if (snapshot.hasData) {
// return DashBoard();
// } else {
// return WelcomePage();
// }
// },
// ),
// )
//
