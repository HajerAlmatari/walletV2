// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:services/services.dart';
// import 'package:walletapp/services/google_sign_in.dart';
//
//
// class DashBoard extends StatefulWidget {
//   DashBoardState createState() => DashBoardState();
// }
//
// class DashBoardState extends State<DashBoard> {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//
//     return Scaffold(
//       drawer: Drawer(
//         child: Container(
//           child: Column(
//             children: [
//               Text('jdkjkd'),
//             ],
//           ),
//         ),
//       ),
//       appBar: AppBar(
//
//           // automaticallyImplyLeading:false,
//         title: Text('Dashboard'),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {
//               final services = Provider.of<GoogleSignInProvider>(context,listen: false);
//               services.googleLogOut();
//               FirebaseAuth.instance.signOut();
//               // user.delete();
//               print("logout");
//             },
//             child: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.white),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(user.email!.toString()),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }
