// import 'dart:convert';
// import 'dart:io';
//
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:provider/provider.dart';
// import 'package:walletapp/screens/nav_screen.dart';
// import 'package:walletapp/services/firebase_auth_methods.dart';
// import 'package:walletapp/widgets/showSnackBar.dart';
// import 'package:http/http.dart' as http;
//
// class GooglePasswordAndPhone extends StatefulWidget {
//   GooglePasswordAndPhoneState createState() => GooglePasswordAndPhoneState();
//
//   final userName = name;
//   GooglePasswordAndPhone({thisname, email, accessToken, idToken});
//
//
//
// }
//
// class GooglePasswordAndPhoneState extends State<GooglePasswordAndPhone> {
//   Color primaryColor = Color.fromRGBO(120, 148, 150, 0.8);
//
//   final _phone = TextEditingController();
//   final _password = TextEditingController();
//   final _confirmPassword = TextEditingController();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final _formkey = GlobalKey<FormState>();
//
//     final emailField = TextFormField(
//       controller: _phone,
//       textInputAction: TextInputAction.done,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       decoration: const InputDecoration(
//         // filled: true,
//         labelText: 'phone number',
//         labelStyle: TextStyle(
//           color: Color.fromRGBO(120, 148, 150, 0.8),
//           fontWeight: FontWeight.bold,
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Color.fromRGBO(120, 148, 150, 0.8),
//           ),
//         ),
//       ),
//       validator: (_user_phone) =>
//       _user_phone != null && !EmailValidator.validate(_user_phone)
//           ? 'Enter a valid phone number'
//           : null,
//     );
//
//     final passwordField = TextFormField(
//       obscureText: true,
//       controller: _password,
//       decoration: const InputDecoration(
//         // filled: true,
//         labelText: 'Password',
//         labelStyle: TextStyle(
//           color: Color.fromRGBO(120, 148, 150, 0.8),
//           fontWeight: FontWeight.bold,
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Color.fromRGBO(120, 148, 150, 0.8),
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please Enter Password';
//         } else {
//           return null;
//         }
//       },
//     );
//
//     final confirmPasswordField = TextFormField(
//       obscureText: true,
//       controller: _password,
//       decoration: const InputDecoration(
//         // filled: true,
//         labelText: 'Password',
//         labelStyle: TextStyle(
//           color: Color.fromRGBO(120, 148, 150, 0.8),
//           fontWeight: FontWeight.bold,
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Color.fromRGBO(120, 148, 150, 0.8),
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please Enter Password';
//         } else if (value!= _password){
//           return "Password Doesn't Match";
//         }
//         else
//           return null;
//       },
//     );
//
//
//     final Signup = GestureDetector(
//       onTap: () {
//         if (_formkey.currentState!.validate()) {
//           ()async{
//
//             final credential = GoogleAuthProvider.credential(
//               accessToken: widget.googleAuth.accessToken,
//               idToken: googleAuth.idToken,
//             );
//
//             // await _auth.signInWithCredential(credential);
//
//             await FirebaseAuth.instance.signInWithCredential(widget.credential);
//           };
//         }
//       },
//       child: Container(
//         height: 50,
//         width: 370,
//         decoration: BoxDecoration(
//           color: const Color.fromRGBO(120, 148, 150, 0.8),
//           borderRadius: BorderRadius.circular(50),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(5, 5),
//               blurRadius: 10,
//             )
//           ],
//         ),
//         child: Center(
//           child: Text(
//             'Sign In',
//             style: TextStyle(
//                 color: Colors.grey[100],
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//
//
//
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: AppBar(
//         title: Text(
//           "Login",
//           style: TextStyle(
//             color: Color.fromRGBO(120, 148, 150, 0.8),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(
//           color: Color.fromRGBO(120, 148, 150, 0.8), // <-- SEE HERE
//         ),
//       ),
//       body: Container(
//         height: 350,
//         padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
//         margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(30)),
//         child: Form(
//           key: _formkey,
//           child: ListView(
//             children: <Widget>[
//               emailField,
//               const SizedBox(
//                 height: 5,
//               ),
//               passwordField,
//               const SizedBox(
//                 height: 20,
//               ),
//               confirmPasswordField,
//               const SizedBox(
//                 height: 30,
//               ),
//               signinbutton,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
