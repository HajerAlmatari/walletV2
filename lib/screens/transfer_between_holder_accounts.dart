import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:walletapp/screens/nav_screen.dart';
import '../Api/RemoteService.dart';
import '../Models/SaveAccount.dart';
import '../Models/SubAccount.dart';
import '../Models/SubAccountNumbers.dart';
import '../widgets/InputField.dart';
import 'package:http/http.dart' as http;

import '../widgets/showSnackBar.dart';


class TBHA extends StatefulWidget {
  const TBHA({Key? key}) : super(key: key);

  @override
  _TBHAState createState() => _TBHAState();
}

class _TBHAState extends State<TBHA> {
  final amountController = TextEditingController();

  List<SubAccount> subAccountsList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }




  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();


    SubAccountNumbers subAccountNumbers= new SubAccountNumbers();
    final  List<SubAccount> subAccountsList = subAccountNumbers.getSubAccountList();
    print("Sub Account List Is  $subAccountsList");
    final List<String> fromAccount = [];
    final List<String> toAccount = [];
    for(var subaccount in subAccountsList){
      fromAccount.add(subaccount.id.toString()+"-"+subaccount.currencyType);
      toAccount.add(subaccount.id.toString()+"-"+subaccount.currencyType);
    }
    String selectedValue = fromAccount[0];
    String selectedValue2 = toAccount[1];


    postData() async {
      var response = await http.post(
        Uri.parse('https://walletv1.azurewebsites.net/api/BankServices/transferToSameAccount'),
        body: jsonEncode({
          "senderSubAccountId" : selectedValue.substring(0, selectedValue.indexOf('-')),
          "receiverSubAccountId" : selectedValue2.substring(0, selectedValue2.indexOf('-')),
          "amonut" : amountController.text,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("SuccessFully");
        print(selectedValue.substring(0, selectedValue.indexOf('-')));
        print(selectedValue2.substring(0, selectedValue2.indexOf('-')));

        EasyLoading.showSuccess("Transfer Has Been Completed Successfully",duration: Duration(milliseconds: 1000));


        await Future.delayed(Duration(milliseconds: 1000));

        EasyLoading.dismiss();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            NavScreen()), (Route<dynamic> route) => false);

        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));

      } else {

        print(selectedValue.substring(0, selectedValue.indexOf('-')));
        print(selectedValue2.substring(0, selectedValue2.indexOf('-')));

        EasyLoading.showError(response.body);
        await Future.delayed(Duration(milliseconds: 1000));

        EasyLoading.dismiss();


        print("Not SuccessFully");
        // print(response.body);
        // print(response.statusCode);

      }
      // print(response.body);
    }






    final transferButton = GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          print(selectedValue.substring(0,10));
          print(selectedValue2.substring(0,10));

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Transfer Between Your Accounts'),
              content:  Text('Are you sure to transfer ${amountController.text} from ${selectedValue.toString()} account to ${selectedValue2.toString()} account !'),
              actions: <Widget>[
                TextButton(
                  onPressed: (){
                    EasyLoading.show();
                    postData();

                  },
                  child: const Text('Yes'),
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

    final fromSubAccount = DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint:  Text(
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
          .map((item) =>
          DropdownMenuItem<String>(
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
        if(selectedValue2==selectedValue){
          return 'you cant transfer between the same account type';
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

    final toSubAccount = DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint:  Text(
        "$selectedValue2",
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
      items: toAccount
          .map((item) =>
          DropdownMenuItem<String>(
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
          value = selectedValue2;
        }
        if(selectedValue2==selectedValue){
          return 'you cant transfer between the same account type';
        }
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
        selectedValue2 = value.toString();
      },
      onSaved: (value) {
        selectedValue2 = value.toString();
      },
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'Transfer between your accounts',
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
              Text('From Account'),
              SizedBox(height: 10,),
              fromSubAccount,
              SizedBox(height: 10,),
              Text('To Accouont'),
              SizedBox(height: 10,),
              toSubAccount,
              SizedBox(height: 30,),
              InputField(amountController,TextInputType.number,'Enter the ammount',false,suffixIcon: Icon(Icons.money)),
              SizedBox(height: 15,),
              transferButton,
            ],
          ),
        ),
      ),
    );

  }

}
