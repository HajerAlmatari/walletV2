import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:walletapp/login.dart';

import '../Models/SignUpData.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/showSnackBar.dart';

class VerifyOTP extends StatefulWidget {
  String verificationId;

  VerifyOTP(this.verificationId);

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final TextEditingController _CodeController1 = TextEditingController();
  final TextEditingController _CodeController2 = TextEditingController();
  final TextEditingController _CodeController3 = TextEditingController();
  final TextEditingController _CodeController4 = TextEditingController();
  final TextEditingController _CodeController5 = TextEditingController();
  final TextEditingController _CodeController6 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  SignUpData obj = SignUpData();
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _phone;
  bool? _isNew;

  @override
  Widget build(BuildContext context) {
    _isNew = obj.getIsNew();
    print(_isNew);

    print("I'm the Sceond: " + widget.verificationId);
    String verificationId = widget.verificationId;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/fingerprint-scanner.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(
                            first: true,
                            last: false,
                            controller: _CodeController1),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            controller: _CodeController2),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            controller: _CodeController3),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            controller: _CodeController4),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            controller: _CodeController5),
                        _textFieldOTP(
                            first: false,
                            last: true,
                            controller: _CodeController6),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                String smsCode = _CodeController1.text +
                                    _CodeController2.text +
                                    _CodeController3.text +
                                    _CodeController4.text +
                                    _CodeController5.text +
                                    _CodeController6.text;

                                print(smsCode);
                                setState(() {
                                  isLoading = true;
                                  if (smsCode.length >= 5) {
                                    verifyOTPCode(verificationId, smsCode);
                                  }
                                });
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(39, 138, 189, 1)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first, last, required TextEditingController controller}) {
    return Container(
      height: 60,
      width: 47,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: Color.fromRGBO(39, 138, 189, 1)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  void verifyOTPCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(credential).then((value) {
      if (_isNew!) {
        print("I Came from Sign Up");
        postData();

      } else {
        print("I Came from Forget");
      }


      setState(() {
        isLoading = false;
      });

      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
    }).onError((error, stackTrace) {
      print("Wrong: " + error.toString());

      setState(() {
        isLoading = false;
      });
    });
  }

  postData() async {
    _firstName = obj.getFirstName();
    _lastName = obj.getLastName();
    _email = obj.getEmail();
    _phone = obj.getPhone();
    _password = obj.getPassword();
    var response = await http.post(
      Uri.parse('https://walletv1.azurewebsites.net/api/Register/new'),
      body: jsonEncode({
        'firstName': _firstName,
        'lastName': _lastName,
        'email': _email,
        'phoneNumber': _phone!,
        'password': _password,
        'socialMediaType': 'normal'
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(_phone);
      print("SuccessFully");

      context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: _email!,
          password: _password!,
          context: context,
          phone: _phone!,
          statusCode: response.statusCode.toString());

      EasyLoading.showSuccess("Account Created Successfully",
          duration: const Duration(milliseconds: 500));

      await Future.delayed(const Duration(milliseconds: 1000));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      showSnackBar(context, response.body);
      print("Not SuccessFully");
      print(response.body);
      print(_phone);
      // print(response.statusCode);
    }
    // print(response.body);
  }
}
