import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:walletapp/Models/SubAccount.dart';
import 'package:walletapp/Models/SubAccountNumbers.dart';
import 'package:walletapp/screens/nav_screen.dart';
import 'package:walletapp/widgets/showSnackBar.dart';
import '../widgets/InputField.dart';
import 'package:http/http.dart' as http;


class InternetADSL extends StatefulWidget {
  const InternetADSL({Key? key}) : super(key: key);

  @override
  _InternetADSLState createState() => _InternetADSLState();
}

class _InternetADSLState extends State<InternetADSL> {
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  List<SubAccount> subAccountsList = [];


  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    SubAccountNumbers subAccountNumbers = new SubAccountNumbers();
    final List<SubAccount> subAccountsList =
    subAccountNumbers.getSubAccountList();
    final List<String> fromAccount = [];
    for (var subaccount in subAccountsList) {
      fromAccount.add(subaccount.id.toString() + "-" + subaccount.currencyType);
    }
    String selectedValue = fromAccount[0];


    postData() async {
      var response = await http.post(
        Uri.parse(
            'https://walletv1.azurewebsites.net/api/Payment/payments'),
        body: jsonEncode({
          "subAccountId": selectedValue.substring(0, selectedValue.indexOf('-')),
          "number": phoneController.text,
          "amount": amountController.text,
          "type" : 5,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("SuccessFully");
        print("Account ID : "+selectedValue.substring(0, selectedValue.indexOf('-')));

        EasyLoading.showSuccess("Transaction Has Been Completed Successfully",duration: Duration(milliseconds: 1000));


        await Future.delayed(Duration(milliseconds: 1000));

        EasyLoading.dismiss();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            NavScreen()), (Route<dynamic> route) => false);


        // EasyLoading.showSuccess("Account Created Successfully",duration: Duration(milliseconds: 500));
        //
        // await Future.delayed(Duration(milliseconds: 1000));
        //
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

      } else {
        print("Account ID : "+selectedValue.substring(0, selectedValue.indexOf('-')));
        EasyLoading.showError(response.body);
        await Future.delayed(Duration(milliseconds: 1000));

        EasyLoading.dismiss();
        print("Not SuccessFully");
        print(response.body);
        // print(response.statusCode);
      }
      // print(response.body);
    }



    String PhonePattern = r'(^(((\+|00)967|0)[1-7]\d{6})$)';
    RegExp regExp = RegExp(PhonePattern);


    final transferButton = GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          EasyLoading.show();

          print(amountController.text);
          print(phoneController.text);
          print(selectedValue);

          postData();
        }
      },
      child: Container(
        height: 50,
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
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    final subAccounts = DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: Text(
        "$selectedValue",
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: fromAccount
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          value = selectedValue;
        }
      },
      onChanged: (value) {
        selectedValue = value.toString();
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Internet ADSL',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(39, 138, 189, 1),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Please select the account'),
              SizedBox(
                height: 10,
              ),
              subAccounts,
              SizedBox(
                height: 10,
              ),
              InputField(
                phoneController,
                TextInputType.number,
                'Phone Number',
                true,
                validator: (value){
                  if (!regExp.hasMatch(value!)) {
                    return 'Please Enter a Valid Phone Number';
                  }
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Phone Number';
                  } else {
                    return null;
                  }
                },
                suffixIcon: Icon(Icons.phone),
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                amountController,
                TextInputType.phone,
                'Enter the ammount',
                false,
                suffixIcon: Icon(Icons.money),
              ),
              SizedBox(
                height: 20,
              ),
              transferButton,
            ],
          ),
        ),
      ),
    );
  }
}
