import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:walletapp/login.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'package:walletapp/widgets/showOtpDialog.dart';
import 'package:walletapp/widgets/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      EasyLoading.show();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);


        EasyLoading.dismiss();
        EasyLoading.showSuccess("account Have been created");

      await Future.delayed(Duration(seconds: 1));

        showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Email Verification'),
                content: const Text('Send Verification Email to your Email'),
                actions: [
                  FlatButton(
                    onPressed: () async{
                      await sendEmailVerification(context, "Email verification sent");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );

                    },
                    child: Text('Send'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );

                    },
                    child: Text('Later'),
                  ),
                ],
              );
            });

    } on FirebaseAuthException catch (e) {
      // if(e.code == 'week-password'){
      //   showSnackBar(context, 'Wrong Password');
      //
      // }
      EasyLoading.dismiss();
      showSnackBar(context, e.message!);
    }
  }

  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      EasyLoading.show();
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!_auth.currentUser!.emailVerified) {
        EasyLoading.dismiss();
        await sendEmailVerification(context, 'Check your email to verify it');
      } else {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.message!);
    }
  }

  // Future<void> signInWithGoogle(BuildContext context) async{
  //   try{
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //     if(googleAuth?.accessToken != null && googleAuth?.idToken != null){
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken,
  //         idToken: googleAuth?.idToken,
  //       );
  //       UserCredential userCredential = await _auth.signInWithCredential(credential);
  //
  //       if(userCredential.user != null){
  //         if(userCredential.additionalUserInfo!.isNewUser){
  //
  //         }
  //       }
  //     }
  //
  //   }on FirebaseAuthException catch(e){
  //       showSnackBar(context, e.message!);
  //   }
  //
  //
  // }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get usr => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      if(_user!=null){

        var names = _user!.displayName!.split(' ');
        String firstName = names[0];
        String lastName = names[1];

        // var name = _user!.displayName?.substring(0, _user!.displayName?.indexOf(" "));
        // var lastName = _user!.displayName?.substring(_user!.displayName?.indexOf(" ")! + 1);
        //
          () async{
          var response =
          await http.post(
            Uri.parse('http://192.168.30.244:7285/api/Register/new'),
            body: jsonEncode({
              'firstName': firstName,
              'lastName': lastName,
              'email': _user!.email.toString(),
              'phoneNumber': '',
              'password': '',
              'socialMediaType': 'google'
            }),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          );

          if (response.statusCode == 200) {
            print("SuccessFully");
            // status = true;
            // if(status)
          } else {
            print("Not SuccessFully");
            print(response.body);
            print(response.statusCode);
          }
          print(response.body);


        };


      }

    } catch (e) {
      print(e.toString());
    }
  }

  Future googleLogOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }


  // Future<void> PhoneSignIn(BuildContext context, String phone) async {
  //   TextEditingController codeController = TextEditingController();
  //   await _auth.verifyPhoneNumber(phoneNumber: phone,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (e) {
  //         showSnackBar(context, e.message!);
  //       },
  //       codeSent: ((String verificationId, int? resendToken) async {
  //         showOTPDialog(context: context,
  //             codeController: codeController,
  //             onPressed: () async {
  //               PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //                   verificationId: verificationId,
  //                   smsCode: codeController.text.trim());
  //
  //               await _auth.signInWithCredential(credential);
  //               Navigator.of(context).pop();
  //             });
  //       }),
  //       codeAutoRetrievalTimeout: (String verificationId){
  //
  //       },
  //   );
  // }



  Future<void> sendEmailVerification(
      BuildContext context, String message) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, message);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      googleLogOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
