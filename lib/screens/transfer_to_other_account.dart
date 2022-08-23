import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:walletapp/Api/RemoteService.dart';
import 'package:walletapp/Models/ClientName.dart';
import 'package:walletapp/Models/SubAccount.dart';
import 'package:walletapp/Models/SubAccountNumbers.dart';
import 'package:walletapp/constants.dart';
import 'package:walletapp/screens/nav_screen.dart';
import '../widgets/InputField.dart';
import '../widgets/showSnackBar.dart';
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
  String client_name = "";






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
          "senderSubAccountId" : selectedValue.substring(0, selectedValue.indexOf('-')),
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
        print("Account ID : "+selectedValue.substring(0, selectedValue.indexOf('-')));
        EasyLoading.dismiss();



        // EasyLoading.showSuccess("Account Created Successfully",duration: Duration(milliseconds: 500));
        //
        await Future.delayed(Duration(milliseconds: 1000));

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            NavScreen()), (Route<dynamic> route) => false);        //
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

      } else {
        EasyLoading.showError(response.body);
        EasyLoading.dismiss();
        Navigator.of(context).pop();

        // showSnackBar(context, response.body);
        print("Not SuccessFully");
        print("Account ID : "+selectedValue.substring(0, selectedValue.indexOf('-')));

        // print(response.body);
        // print(response.statusCode);
      }
      // print(response.body);
    }





    final transferButton = GestureDetector(
      onTap: () {


        if (_formkey.currentState!.validate()) {
          getClientNameRequest();

          Future.delayed(const Duration(milliseconds: 1000));

          // print("from dialog name is : "+name.toString());

          final  commission = ( int.parse(amountController.text) * (2/1000));
          final total = int.parse(amountController.text) + commission;

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Confirm'),
              content:  Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12,width: 1.0)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('From Account  : ${selectedValue.toString()}'),
                    Text('To Account       : ${toAccountController.text}'),
                    Text('To Name          : ${client_name}'),
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
              // content:  Text('Are you sure to transfer ${amountController.text} from ${selectedValue.toString()} account to ${toAccountController.text} account. with commission ${commission} total '),
              actions: <Widget>[
                TextButton(
                  onPressed: (){
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
              InputField(
                amountController,
                TextInputType.number,
                  'Enter the ammount',
                false,
                  suffixIcon: Icon(Icons.money),
              ),
              SizedBox(
                height: 10,
              ),
              InputField(toAccountController, TextInputType.number,
                  'To Account',
                  true,
                  validator: (value){
                    if (value.toString().length != 10) {
                      return 'Please Enter a Valid Account Number';
                    }
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Account Number';
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: null,
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


  Future<String> getClientNameRequest() async {
    try {
      var response = await http.get(Uri.parse('https://walletv1.azurewebsites.net/api/BankServices/'+toAccountController.text),);

      print("Status Code ${response.statusCode}");
      print("Response Body ${response.body}");

      if (response.statusCode == 200) {
        var json = response.body;
        ClientName clientName = clientNameFromJson(json);

        print(clientName.fullName);

        setState((){
          client_name = clientName.fullName;
        });

        print("SuccessFully");

        // showSnackBar(context, "Successfully Logged in");

        return clientName.fullName;

      } else {
       return "";
      }
    } catch (error) {
      print(error.toString());
      return(error.toString());
    }
  }




}

