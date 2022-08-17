import 'package:flutter/material.dart';
import 'package:walletapp/login.dart';
import 'package:walletapp/screens/fingerprint.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';
import 'signup.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context);
    final logo = Image.asset(
      width: 200,
      height: 200,
      'images/bank_logo.png',
    );
    final signinbutton = GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: Container(
        height: 70,
        width: 370,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(39, 138, 189, 1),
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 100),
            Center(
              child: Text(
                'Sign In With Your Account',
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 40),
            const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
          ],
        ),
      ),
    );


    final signupbutton = GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignupPage()));
      },
      child: Container(
        height: 70,
        width: 370,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(39, 138, 189, 1),
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 130),
            Center(
              child: Text(
                'Open An Account',
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 70),
            Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
          ],
        ),
      ),
    );



    final signWithGoogle = GestureDetector(
      child: Container(
        height: 50,
        width: 260,
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
              'images/google.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 20,),
            const Text("Sign In With Google")
          ],
        ),
      ),
      onTap: (){
        // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
        // provider.googleLogin();


        /////////New Login Option/////////////
        context.read<FirebaseAuthMethods>().googleLogin();


        //new function :(

        // context.read<FirebaseAuthMethods>().signInWithGoogle(context);
      },
    );

    Widget divider() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: const <Widget>[
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            Text('or'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      );
    }



  return Scaffold(
    // backgroundColor: Color.fromRGBO(244, 244, 244, 300),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo,
              const SizedBox(height: 30),
              signinbutton,
              const SizedBox(height: 15),
              signupbutton,
              const SizedBox(height: 20),
              divider(),
              const SizedBox(height: 20),
              signWithGoogle,
               const SizedBox(height: 10),
               FingerprintPage(),
            ],
          ),
        ),
      ),
    );
  }

}
