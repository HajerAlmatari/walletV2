import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _userEmail = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TextEditingController _userEmail = TextEditingController();
    EasyLoading.init();
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 138, 189, 1),
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: TextStyle(
            color: Color.fromRGBO(39, 138, 189, 1),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(39, 138, 189, 1), // <-- SEE HERE
        ),
      ),
      body: Container(
        height: 190,
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
                  keyboardType: TextInputType.emailAddress,
                  controller: _userEmail,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userEmail) =>
                      _userEmail != null && !EmailValidator.validate(_userEmail)
                          ? 'Enter a valid Email'
                          : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: Color.fromRGBO(39, 138, 189, 1),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      resetPassword();
                    }
                  },
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    'Reset Password',
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

  Future resetPassword() async {

    try {
      EasyLoading.show();

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _userEmail.text.trim());
      EasyLoading.showSuccess('Check Your Email to Reset Password',duration: Duration(milliseconds: 2000));
      Navigator.of(context).popUntil((route) => route.isFirst);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
