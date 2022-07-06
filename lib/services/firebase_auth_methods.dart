import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:walletapp/login.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'package:walletapp/screens/otp_verfication.dart';
import 'package:walletapp/widgets/showOtpDialog.dart';
import 'package:walletapp/widgets/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
    required String phone,
  }) async {
    try {
      EasyLoading.show();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      EasyLoading.dismiss();
      EasyLoading.showSuccess("account Have been created");

      await Future.delayed(Duration(milliseconds: 1500));

      showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Email Verification'),
              content: const Text('Open your email to verify your account'),
              actions: [
                FlatButton(
                  onPressed: () async {
                    await sendEmailVerification(
                        context, "Email verification sent");

                    // phoneVerification(context, phone);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => LoginPage()),
                    // );
                  },
                  child: Text('Ok'),
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

      if (_user != null) {
        var names = _user!.displayName!.split(' ');
        String firstName = names[0];
        String lastName = names[1];

        // var name = _user!.displayName?.substring(0, _user!.displayName?.indexOf(" "));
        // var lastName = _user!.displayName?.substring(_user!.displayName?.indexOf(" ")! + 1);
        //
        () async {
          var response = await http.post(
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

  /*
  Future<void> phonSignup(BuildContext context, String phone) async {
    TextEditingController codeController = TextEditingController();
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("Success");
      },
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        showOTPDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeController.text.trim());

              await _auth.signInWithCredential(credential);
              Navigator.of(context).pop();
            });
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        showSnackBar(context, "Timeout");
      },
    );
  }
*/

  Future<void> phonSignup(
      {required BuildContext context, required String phone}) async {
    TextEditingController codeController = TextEditingController();
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await _auth.signInWithCredential(credential);
        print("Success");
      },
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        showOTPDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeController.text.trim());

              await _auth.signInWithCredential(credential);
              Navigator.of(context).pop();
            });
      }),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  //
  // Future<void> phoneVerification(BuildContext context, String phone) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       showSnackBar(context, "Phone Verified");
  //       await Future.delayed(Duration(milliseconds: 1000));
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => LoginPage()));
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       showSnackBar(context, e!.message.toString());
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Otp()));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       showSnackBar(context, "Time Out");
  //     },
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
