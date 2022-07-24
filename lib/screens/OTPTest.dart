import 'dart:convert';
import 'dart:io';

import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:walletapp/Models/SignUpData.dart';

import '../widgets/showSnackBar.dart';

class OTPPage extends StatefulWidget {
  OTPPageState createState() => OTPPageState();
}

class OTPPageState extends State<OTPPage> {
  TextEditingController _userPhone = TextEditingController();
  TextEditingController _smsCode = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  String verificationID = "";



  @override
  Widget build(BuildContext context) {


    // TextEditingController _userEmail = TextEditingController();

    EasyLoading.init();


    return Scaffold(
      backgroundColor: Color.fromRGBO(120, 148, 150, 0.8),
      appBar: AppBar(
        title: Text(
          "Forget Password",
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
        height: 300,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _userPhone,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Number',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: Color.fromRGBO(120, 148, 150, 0.8),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print("I'm Clicked");
                      verifyPhone();
                    }
                  },
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _smsCode,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Code',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: Color.fromRGBO(120, 148, 150, 0.8),
                  ),
                  onPressed: () {
                    print("I'm Clicked");
                    signIn();
                  },
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    'Verify',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhone() async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(minutes: 2),
      phoneNumber: _userPhone.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void signIn() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: _smsCode.text);
    await auth.signInWithCredential(credential).then((value) {

      print("You are logged in successfully");

      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
    });
  }

 /* postData() async {
    var response = await http.post(
      Uri.parse('https://walletv.azurewebsites.net/api/Register/new'),
      body: jsonEncode({
        'firstName': _firstName.text,
        'lastName': _lastName.text,
        'email': _email.text,
        'phoneNumber': _phoneNumber.text,
        'password': _password.text,
        'socialMediaType': 'normal'
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("SuccessFully");


      // EasyLoading.showSuccess("Account Created Successfully",duration: Duration(milliseconds: 500));
      //
      // await Future.delayed(Duration(milliseconds: 1000));
      //
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

    } else {
      showSnackBar(context, response.body);
      print("Not SuccessFully");
      // print(response.body);
      // print(response.statusCode);
    }
    // print(response.body);
  }*/
}
