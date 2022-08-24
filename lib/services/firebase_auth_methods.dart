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
import '../Models/LoginResponse.dart';
import '../Models/SaveAccount.dart';

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
    required String statusCode
  }) async {
    try {
     if(statusCode == '200'){
       EasyLoading.show();
       await _auth.createUserWithEmailAndPassword(
           email: email, password: password);

       EasyLoading.dismiss();



       EasyLoading.showSuccess("Account Created Successfully",duration: Duration(milliseconds: 500));
       //
       // await Future.delayed(Duration(milliseconds: 1000));
       //
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
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));

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
     }
    } on FirebaseAuthException catch (e) {
      if(e.code == 'week-password'){
        showSnackBar(context, 'Wrong Password');
      }
      else if ( e.code == 'email-already-in-use'){
        showSnackBar(context, 'Email already used');
      }

      EasyLoading.dismiss();
      showSnackBar(context, e.message!);
    }
  }

  Future<void> loginWithPhone(
      {required String phone,
        required String password,
        required BuildContext context}) async {
    try {
      EasyLoading.show();
      await _auth.signInWithPhoneNumber(phone);


      EasyLoading.dismiss();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          NavScreen()), (Route<dynamic> route) => false);

    } on FirebaseAuthException catch (e) {
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


        EasyLoading.dismiss();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          NavScreen()), (Route<dynamic> route) => false);

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.message!);
    }
  }

/*
  Future<void> signInWithGoogle(BuildContext context) async{
    try{

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if(googleAuth?.accessToken!=null && googleAuth?.idToken!=null){

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        print("Access Token : "+ credential.accessToken.toString());
        print("ID Token : "+ credential.idToken.toString());

        UserCredential userCredential = await _auth.signInWithCredential(credential);



        if(userCredential.user != null){

          print("user Credintial : "+userCredential.user.toString());



          if(userCredential.additionalUserInfo!.isNewUser){
            //post sign up

            print("New User");
          }

          else{
            //post Log in
            print("Old User");
          }

        }




      }




    }on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
    }
  }

*/

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get usr => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      print("Google Sign In "+googleUser.toString());

      if (googleUser == null) {
        print("User Is Null");
        return;
      }

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var response = await _auth.signInWithCredential(credential);

      print(response);
      print("User = "+_user.toString());

      if (response != null) {
        var names = _user!.displayName!.split(' ');
        String firstName = names[0];
        String lastName = names[1];

        print(firstName);
        print(lastName);
        print(_user!.email.toString());
        // var name = _user!.displayName?.substring(0, _user!.displayName?.indexOf(" "));
        // var lastName = _user!.displayName?.substring(_user!.displayName?.indexOf(" ")! + 1);

/*
          var response = await http.post(
            Uri.parse('https://walletv1.azurewebsites.net/api/Register/new'),
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
            print(_user!.email.toString()+" SuccessFully 200");
            print(firstName+" SuccessFully 200");
            print(lastName+" SuccessFully 200");
            // status = true;
            // if(status)

          } else {
            print("Not SuccessFully");
            print(response.body);
            print(response.statusCode);
          }
          print(response.body);


 */

      }

      else{


        var response = await http.post(
          Uri.parse('https://walletv1.azurewebsites.net/api/Login/signin'),
          body: jsonEncode({
            'paramter': _user!.email.toString(),
            'password': '',
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        );

        if (response.statusCode == 200) {
          var json = response.body;
          LoginResponse loginResponse = loginResponseFromJson(json);

          SaveAccount obj =  SaveAccount();
          print(loginResponse.accountId.elementAt(0));
          int account = loginResponse.accountId.elementAt(0);
          obj.setId(account);
          print("Your Id: is: " +obj.getId().toString() );
          print(loginResponse.message);

          print("SuccessFully");




        } else if (response.statusCode == 404) {

          print(response.body);
          print(response.statusCode);

        }  else {
          print(response.statusCode);
        }


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
  //
  // Future<void> signupWithPhoneNumber(BuildContext context, String phone,String email)async{
  //
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async{
  //       await _auth.signInWithEmailLink(credential,);
  //     },
  //
  //
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  //
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
