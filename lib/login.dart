import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/Models/LoginResponse.dart';
import 'package:walletapp/Models/SaveAccount.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'package:walletapp/screens/reset_password.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';
import 'package:walletapp/signup.dart';
import 'package:walletapp/widgets/showSnackBar.dart';
import 'package:walletapp/Models/SignUpData.dart';

import 'forgetPassword.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Color primaryColor = Color.fromRGBO(39, 138, 189, 1);

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  loginRequest() async {
    print("request");
    EasyLoading.show();
    try {
      var response = await http.post(
        Uri.parse('https://walletv1.azurewebsites.net/api/Login/signin'),
        body: jsonEncode({
          'paramter': _email.text,
          'password': _password.text,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        var json = response.body;
        LoginResponse loginResponse = loginResponseFromJson(json);

        SaveAccount obj = new SaveAccount();
        print(loginResponse.accountId.elementAt(0));
        int account = loginResponse.accountId.elementAt(0);
        obj.setId(account);
        print("Your Id: is: " + obj.getId().toString());
        print(loginResponse.message);

        print("SuccessFully");

        showSnackBar(context, "Successfully Logged in");

        context.read<FirebaseAuthMethods>().loginWithEmail(
            email: _email.text.trim(),
            password: _password.text.trim(),
            context: context);

        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        //     NavScreen()), (Route<dynamic> route) => false);

        EasyLoading.dismiss();

      } else if (response.statusCode == 404) {
        // EasyLoading.dismiss();
        showSnackBar(context, "Not found URL");

        // print(response.body);
        // print(response.statusCode);

      } else if (response.statusCode == 7) {
        EasyLoading.dismiss();
        showSnackBar(context, "No Internet connection");
      } else {
        EasyLoading.dismiss();
        print(response.statusCode);
        showSnackBar(context, "Phone or Password wrong");
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    final emailField = TextFormField(
      controller: _email,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'Email/phone number',
        labelStyle: TextStyle(
          color: Color.fromRGBO(39, 138, 189, 1),
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(39, 138, 189, 1),
          ),
        ),
      ),
      validator: (_userEmail) =>
          _userEmail != null && !EmailValidator.validate(_userEmail)
              ? 'Enter a valid Email or phone number'
              : null,
    );

    final passwordField = TextFormField(
      obscureText: true,
      controller: _password,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Color.fromRGBO(39, 138, 189, 1),
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(39, 138, 189, 1),
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

    final signinbutton = GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          EasyLoading.show(status: 'Loading ...');
          loginRequest();
          // context.read<FirebaseAuthMethods>().loginWithEmail(email: _email.text.trim(), password: _password.text.trim(), context: context);
          EasyLoading.dismiss();
        }
      },
      child: Container(
        height: 60,
        width: 370,
        decoration: BoxDecoration(
          color: Color.fromRGBO(39, 138, 189, 1),
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
      alignment: const Alignment(1, 0),
      child: InkWell(
        onTap: () {
          SignUpData obj = SignUpData();
          obj.setIsNew(false);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ResetPasswordPage()));
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
    final signUp = Container(
      alignment: Alignment(1, 0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignupPage()));
        },
        child: const Text(
          'Sign Up?',
          style: TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            color: Color.fromRGBO(39, 138, 189, 1),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(39, 138, 189, 1),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage("images/wallet-backgroud.png"),
          ),
          color: Colors.white,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 350,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          margin: EdgeInsets.fromLTRB(10, 100, 10, 20),
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
                  height: 20,
                ),
                signUp,
                const SizedBox(
                  height: 30,
                ),
                signinbutton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signInfirebase() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());

      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      //     NavScreen()), (Route<dynamic> route) => false);

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
  void loginUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: _email.text.trim(),
        password: _password.text.trim(),
        context: context);
  }
}
