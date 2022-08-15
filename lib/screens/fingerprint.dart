import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart' as services;
import 'package:walletapp/screens/nav_screen.dart';


class FingerprintPage extends StatelessWidget {
   FingerprintPage({Key? key}) : super(key: key);

  final LocalAuthentication auth = LocalAuthentication();
   Future<bool> _authenticateWithBiometrics(BuildContext context) async {
     bool isAuth = false;
     try {

       bool authStatus = await auth.authenticate(
            androidAuthStrings: AndroidAuthMessages(
              signInTitle: "auth-confirm", biometricHint: ""),
           localizedReason: 'scan-fingerprint',
           useErrorDialogs: true,
           stickyAuth: true,
           biometricOnly: true);
       if (authStatus) {
         print("fgggggggggggggggggggggggggg");
       } else {
         isAuth = true;
       }
     } on services.PlatformException catch (e) {
       isAuth = true;
     print("error");
       return false;
     } catch (e) {
       isAuth = true;
      print("error 2");
       return false;
     }
     return isAuth;
   }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: Scaffold(
        body: ElevatedButton(
          onPressed: () async{
            print("555555555");
         bool isNotAuthenticated=await   _authenticateWithBiometrics(context);
         if(!isNotAuthenticated) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavScreen(),
                  ));
            }
          },
          child: Text("Fingerprint"),
        ),
      ),
    );
  }
}
