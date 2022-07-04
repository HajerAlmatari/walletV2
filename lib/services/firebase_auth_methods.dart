import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<void> signUpWithEmail({required String email,
    required String password,
    required BuildContext context}) async {
    try {
      EasyLoading.show();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);



      if(!_auth.currentUser!.emailVerified){
        await sendEmailVerification(context,"Email verification sent");
        EasyLoading.dismiss();

        showDialog<void>(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: const Text('Email Verification'),
                content: const Text('open your mailbox to verify your email'),
                actions: [
                  FlatButton(
                    onPressed: () {
                      _auth.currentUser!.emailVerified?
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NavScreen()),
                      )
                      :
                      Navigator.of(context).pop();
                    },
                    child: Text('Verify'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('cancle'),
                  ),
                ],
              );
            }
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavScreen()),
        );
      }
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
      {required String email, required String password, required BuildContext context}) async {
    try {
      EasyLoading.show();
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!_auth.currentUser!.emailVerified) {
        EasyLoading.dismiss();
        await sendEmailVerification(context,'Check your email to verify it');
      }
      else{
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

  Future googleLogin() async{
    try{

      final googleUser = await googleSignIn.signIn();

      if(googleUser == null) return;

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);



    }catch(e){
      print(e.toString());
    }
  }

  Future googleLogOut() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  /*

  Future<void> PhoneSignIn(BuildContext context, String phone) async {
    TextEditingController codeController = TextEditingController();
    await _auth.verifyPhoneNumber(phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          showOTPDialog(context: context,
              codeController: codeController,
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: codeController.text.trim());

                await _auth.signInWithCredential(credential);
                Navigator.of(context).pop();
              });
        }),
        codeAutoRetrievalTimeout: (String verificationId){

        },
    );
  }
*/

  Future<void> sendEmailVerification(BuildContext context,String message) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, message);

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> signOut(BuildContext context) async{

    try{
      await _auth.signOut();
      googleLogOut();
    }on FirebaseAuthException catch(e){
        showSnackBar(context, e.message!);
    }


  }

}
