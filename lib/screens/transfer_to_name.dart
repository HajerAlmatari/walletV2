import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:walletapp/Models/SubAccount.dart';
import 'package:walletapp/Models/SubAccountNumbers.dart';
import 'package:walletapp/constants.dart';
import 'package:walletapp/screens/nav_screen.dart';
import '../widgets/InputField.dart';
import 'package:http/http.dart' as http;

class TTN extends StatefulWidget {
  const TTN({Key? key}) : super(key: key);

  @override
  _TTNState createState() => _TTNState();
}

class _TTNState extends State<TTN> {
  final amountController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  List<SubAccount> subAccountsList = [];

  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    SubAccountNumbers subAccountNumbers = SubAccountNumbers();
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
            'https://walletv1.azurewebsites.net/api/BankServices/transferToPerson'),
        body: jsonEncode({
          "senderSubAccountId":
              selectedValue.substring(0, selectedValue.indexOf('-')),
          "receiverphoneNumber": phoneController.text,
          "receiverName": nameController.text,
          "amonut": amountController.text,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      // 5/100

      if (response.statusCode == 200) {
        print("SuccessFully");
        print(selectedValue.substring(0, selectedValue.indexOf('-')));
        EasyLoading.showSuccess("Transfer Completed Successfully");

        // EasyLoading.showSuccess("Account Created Successfully",duration: Duration(milliseconds: 500));
        //
        // await Future.delayed(Duration(milliseconds: 1000));
        await Future.delayed(const Duration(milliseconds: 1000));
        //

        EasyLoading.dismiss();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => NavScreen()),
            (Route<dynamic> route) => false);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

      } else {
        print(selectedValue.substring(0, selectedValue.indexOf('-')));

        EasyLoading.showError(response.body);
        await Future.delayed(const Duration(milliseconds: 2000));

        EasyLoading.dismiss();
        Navigator.of(context).pop();

        print("Not SuccessFully");

        // print(response.body);
        // print(response.statusCode);
      }
      // print(response.body);
    }

    String PhonePattern = r'(^(((\+|00)9677|0?7)[0137]\d{7})$)';
    RegExp regExp = RegExp(PhonePattern);

    final transferButton = GestureDetector(
      onTap: () {
        EasyLoading.show(status: 'Loading ...');

        if (_formkey.currentState!.validate()) {
          final commission = (int.parse(amountController.text) * (5 / 1000));
          final total = int.parse(amountController.text) + commission;

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Center(child: const Text('Confirm')),
              content: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('From Account  : ${selectedValue.toString()}'),
                    Text('To                       : ${nameController.text}'),
                    Text('phone                : ${phoneController.text}'),
                    Text('Ammount          : ${amountController.text}'),
                    Text('Commission     : ${commission}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black12, width: 1.0,)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Total                   : ${total}         ',
                        style: TextStyle(color: CDarkerColor),),
                      ),
                    ),
                  ],
                ),
              ),
              // content:  Text('Are you sure to transfer ${amountController.text} from ${selectedValue.toString()} account to ${nameController.text} , ${phoneController.text} !'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    EasyLoading.show();
                    postData();
                  },
                  child: const Text('Confirm'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          );
        }
        EasyLoading.dismiss();
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
        style: const TextStyle(fontSize: 14),
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
        value ??= selectedValue;
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
          'Send Remittance',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(39, 138, 189, 1),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Please select the account'),
              const SizedBox(
                height: 10,
              ),
              subAccounts,
              const SizedBox(
                height: 20,
              ),
              InputField(
                  nameController, TextInputType.text, 'Enter the Name', false,
                  suffixIcon: const Icon(Icons.person)),
              const SizedBox(
                height: 10,
              ),
              InputField(
                phoneController,
                TextInputType.phone,
                'Beneficiary Mobile',
                true,
                validator: (value) {
                  if (!regExp.hasMatch(value!)) {
                    return 'Please Enter a Valid Phone Number';
                  }
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Phone Number';
                  } else {
                    return null;
                  }
                },
                suffixIcon: null,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(amountController, TextInputType.number,
                  'Enter the amount', false,
                  suffixIcon: Icon(Icons.money)),
              const SizedBox(
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
