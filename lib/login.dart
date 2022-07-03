import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/dashboard.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';

import 'forgetPassword.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Color primaryColor = Color.fromRGBO(120, 148, 150, 0.8);

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Color.fromRGBO(120, 148, 150, 0.8),
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(120, 148, 150, 0.8),
          ),
        ),
      ),
      validator: (_userEmail) =>
          _userEmail != null && !EmailValidator.validate(_userEmail)
              ? 'Enter a valid Email'
              : null,
    );
    final passwordField = TextFormField(
      obscureText: true,
      controller: _password,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Color.fromRGBO(120, 148, 150, 0.8),
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(120, 148, 150, 0.8),
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Password';
        } else {
          return null;
        }
      },
    );
    // final rememberForNextLogin = Container();
    // final fingerprintNextLogin = Container();

    final signinbutton = GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {

          context.read<FirebaseAuthMethods>().loginWithEmail(email: _email.text.trim(), password: _password.text.trim(), context: context);




        }
      },
      child: Container(
        height: 50,
        width: 370,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(120, 148, 150, 0.8),
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Center(
          child: Text(
            'login',
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    final forgetPassword = Container(
      alignment: Alignment(1, 0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
        },
        child: const Text(
          'Forgot Password ?',
          style: TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            color: Color.fromRGBO(120, 148, 150, 0.8),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(120, 148, 150, 0.8), // <-- SEE HERE
        ),
      ),
      body: Container(
        height: 350,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              emailField,
              const SizedBox(
                height: 5,
              ),
              passwordField,
              const SizedBox(
                height: 20,
              ),
              forgetPassword,
              const SizedBox(
                height: 30,
              ),
              signinbutton,

            ],
          ),
        ),
      ),
    );
  }


  Future signInfirebase() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim());


      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => NavScreen()));

      // Navigator.of(context)
      //     .pushReplacement(MaterialPageRoute(builder: (context) => DashBoard()));

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => DashBoard()),
      //       (Route<dynamic> route) => false,
      // );

    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),


      );

    } on FirebaseAuthException catch (e) {
      print(e);
    }


  }

  //Added Function
  void loginUser(){
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(email: _email.text.trim(), password: _password.text.trim(), context: context);
  }

}
