import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  ForgetPasswordPageState createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _userEmail = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TextEditingController _userEmail = TextEditingController();
    EasyLoading.init();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 138, 189, 1),
      appBar: AppBar(
        title: const Text(
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
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _userEmail,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
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
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    primary: const Color.fromRGBO(39, 138, 189, 1),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      resetPassword();
                    }
                  },
                  icon: const Icon(Icons.email_outlined),
                  label: const Text(
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
      EasyLoading.showSuccess('Check Your Email to Reset Password',duration:
      const Duration(milliseconds: 2000));
      Navigator.of(context).popUntil((route) => route.isFirst);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
