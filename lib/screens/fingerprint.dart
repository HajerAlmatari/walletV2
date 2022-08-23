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
            androidAuthStrings: const AndroidAuthMessages(
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
    return GestureDetector(
      child: Container(
        height: 70,
        width: 290,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/fingerprint.svg',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 20,),
            const Text("Fingerprint")
          ],
        ),
      ),
      onTap: () async{
        print("555555555");
        bool isNotAuthenticated=await _authenticateWithBiometrics(context);
        if(!isNotAuthenticated) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavScreen(),
              ));
        }
      },
    );
    //   Container(
    //   height: 50,
    //   width: 260,
    //   child: ElevatedButton(
    //       onPressed: () async{
    //         print("555555555");
    //      bool isNotAuthenticated=await   _authenticateWithBiometrics(context);
    //      if(!isNotAuthenticated) {
    //           Navigator.pushReplacement(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => const NavScreen(),
    //               ));
    //         }
    //       },
    //       child: Text("Fingerprint"),
    //     ),
    // );
  }
}
