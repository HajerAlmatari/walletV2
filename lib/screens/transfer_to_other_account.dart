import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:walletapp/Models/SubAccount.dart';
import 'package:walletapp/Models/SubAccountNumbers.dart';
import '../widgets/InputField.dart';
import 'package:http/http.dart' as http;


class TTOA extends StatefulWidget {
  const TTOA({Key? key}) : super(key: key);

  @override
  _TTOAState createState() => _TTOAState();
}

class _TTOAState extends State<TTOA> {
  final amountController = TextEditingController();
  final toAccountController = TextEditingController();
  List<SubAccount> subAccountsList=[];


  // List of items in our dropdown menu














  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();


    SubAccountNumbers subAccountNumbers= new SubAccountNumbers();
    final  List<SubAccount> subAccountsList= subAccountNumbers.getSubAccountList();
    final List<String> fromAccount = [];
    for(var subaccount in subAccountsList){
      fromAccount.add(subaccount.id.toString()+"-"+subaccount.currencyType);
    }
    String selectedValue = fromAccount[0];


    postData() async {
      var response = await http.post(
        Uri.parse('https://walletv1.azurewebsites.net/api/BankServices/transferToAnotherAccount'),
        body: jsonEncode({
          "senderSubAccountId" : selectedValue.substring(0,10),
          "receiverSubAccountId" : toAccountController.text,
          "amonut" : amountController.text,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {

        EasyLoading.showSuccess(response.body);
        print("SuccessFully");
        EasyLoading.dismiss();



        // EasyLoading.showSuccess("Account Created Successfully",duration: Duration(milliseconds: 500));
        //
        await Future.delayed(Duration(milliseconds: 1000));

        Navigator.pop(context);
        //
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

      } else {
        EasyLoading.showError(response.body);
        EasyLoading.dismiss();
        // showSnackBar(context, response.body);
        print("Not SuccessFully");
        // print(response.body);
        // print(response.statusCode);
      }
      // print(response.body);
    }




    final transferButton = GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {

          EasyLoading.show();

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
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
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
        //Do something when changing the item if you want.
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
          'Transfer to other account',
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
            //  EasyLoading.show();
              Text('Please select the account'),
              SizedBox(
                height: 10,
              ),
              subAccounts,
              SizedBox(
                height: 10,
              ),
              InputField(amountController, TextInputType.number,
                  'Enter the ammount', false,
                  suffixIcon: Icon(Icons.money)),
              SizedBox(
                height: 10,
              ),
              InputField(toAccountController, TextInputType.number,
                  'To Account', false,
                  suffixIcon: null),
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
