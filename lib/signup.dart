import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/services/firebase_auth_methods.dart';
import 'package:http/http.dart' as http;
import 'package:crypt/crypt.dart';
import 'package:email_validator/email_validator.dart';
import 'package:walletapp/Models/SignUpData.dart';
import 'package:walletapp/screens/verifyOTPScreen.dart';
import 'package:walletapp/widgets/showSnackBar.dart';

class SignupPage extends StatefulWidget {
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _idNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPssword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isChecked = false;
  bool isLoading = false;
  bool status = false;

  bool otpVisibility = false;
  String verificationID = "";

  @override
  void initState() {
    super.initState();
  }

  postData() async {
    String pass = Crypt.sha256(_password.text).toString();
    var response = await http.post(
      Uri.parse('https://walletv1.azurewebsites.net/api/Register/new'),
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

      context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: _email.text.trim(),
          password: _password.text.trim(),
          context: context,
          phone: _phoneNumber.text.trim(),
          statusCode: response.statusCode.toString());

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
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color.fromRGBO(39, 138, 189, 1);

    //Color primaryColor = Color.fromRGBO(120, 148, 150, 0.8);


    String PhonePattern =
        r'(^(((\+|00)9677|0?7)[0137]\d{7}|((\+|00)967|0)[1-7]\d{6})$)';
    RegExp regExp = RegExp(PhonePattern);

    final firstNameField = TextFormField(
      controller: _firstName,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'First Name',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter First Name';
        } else {
          return null;
        }
      },
    );
    final lastNameField = TextFormField(
      controller: _lastName,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'Last Name',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Last Name';
        } else {
          return null;
        }
      },
    );
    final phoneNumberField = TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phoneNumber,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'Phone Number',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (!regExp.hasMatch(value!)) {
          return 'Please enter valid mobile number';
        }
        if (value.isEmpty) {
          return 'Please Enter Phone';
        } else {
          return null;
        }
      },
    );
    final idNumberField = TextFormField(
      keyboardType: TextInputType.number,
      controller: _idNumber,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'ID Number',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter User Name';
        } else {
          return null;
        }
      },
    );
    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _email,
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (_email) => _email != null && !EmailValidator.validate(_email)
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Password';
        } else {
          return null;
        }
      },
    );
    final passwordValidator = FlutterPwValidator(
      controller: _password,
      minLength: 8,
      uppercaseCharCount: 1,
      numericCharCount: 3,
      specialCharCount: 1,
      normalCharCount: 3,
      width: 400,
      height: 150,
      onSuccess: () {
        print("MATCHED");
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Password is matched")));
      },
      onFail: () {
        print("NOT MATCHED");
      },
    );
    final confirmPasswordField = TextFormField(
      obscureText: true,
      controller: _confirmPssword,
      decoration: const InputDecoration(
        // filled: true,
        labelText: 'Confirm Password',
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != _password.text) {
          return "Password doesn't match";
        }
        if (value == null || value.isEmpty) {
          return 'Please Enter The Password Agian';
        } else {
          return null;
        }
      },
    );

    final signinbutton = GestureDetector(
      onTap: () async {
        // context.read<FirebaseAuthMethods>().signUpWithEmail(
        //     email: _email.text.trim(),
        //     password: _password.text.trim(),
        //     context: context,
        //     phone: _phoneNumber.text.trim());

        //   print("tapped");
        if (_formkey.currentState!.validate()) {
          SignUpData obj = new SignUpData();
          obj.setFirstName(_firstName.text);
          obj.setLastName(_lastName.text);
          obj.setEmail(_email.text);
          obj.setPhone("+967${_phoneNumber.text}");
          obj.setPassword(_password.text);
          obj.setIsNew(true);

          setState(() {
            isLoading = true;
            verifyPhone();
          });

          //  postData();
          //     print("validated");
          //
          //     try {
          //       try {
          //         print("Try");
          //         final newUser = await _auth.createUserWithEmailAndPassword(
          //             email: _email.text, password: _password.text);
          //
          //         if (newUser != null) {
          //           print("user not null");
          //           Navigator.pushNamed(context, 'welcome_screen');
          //         } else {
          //           print("null");
          //         }
          //       } catch (e) {
          //         print(e);
          //       }
          //     } catch (e) {
          //       print(e);
          //     }
          //
        } else
          print("Error");
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
            'Sign Up',
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    // final privacyPolicyCheckBox = Checkbox(
    //       checkColor: Colors.white,
    //       fillColor: MaterialStateProperty.resolveWith(getColor),,
    //       value: isChecked,
    //       onChanged: (bool? value) {
    //         setState(() {
    //           isChecked = value!;
    //         });
    //       },
    //     );

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          "Create Account",
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
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              firstNameField,
              const SizedBox(
                height: 5,
              ),
              lastNameField,
              const SizedBox(
                height: 5,
              ),
              phoneNumberField,
              const SizedBox(
                height: 5,
              ),
              idNumberField,
              const SizedBox(
                height: 5,
              ),
              emailField,
              const SizedBox(
                height: 5,
              ),
              passwordField,
              const SizedBox(
                height: 5,
              ),
              passwordValidator,
              const SizedBox(
                height: 5,
              ),
              confirmPasswordField,
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : signinbutton,
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhone() async {
    String number = "+967${_phoneNumber.text}";
    print(number);
    await auth.verifyPhoneNumber(
      timeout: const Duration(minutes: 2),
      phoneNumber: "+967${_phoneNumber.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        /* await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      */
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        showSnackBar(context, e.message.toString());
        isLoading = false;
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => VerifyOTP(verificationId)));
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {
          isLoading = false;
        });
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

// Future signUpmethod() async {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(
//             child: CircularProgressIndicator(),
//           ));
//
//   try {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _email.text.trim(), password: _password.text.trim());
//
//     // Navigator.of(context)
//     //     .push(MaterialPageRoute(builder: (context) => DashBoard()));
//
//     // Navigator.pushAndRemoveUntil(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => DashBoard()),
//     //       (Route<dynamic> route) => false,
//     // );
//
//   } on FirebaseAuthException catch (e) {
//     print(e);
//   }
// }
//
// void signUpUser() async {
//   FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
//       email: _email.text.trim(),
//       password: _password.text.trim(),
//       context: context,
//       phone: _phoneNumber.text.trim());
// }
}
