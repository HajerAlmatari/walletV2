import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/InputField.dart';

class TBHA extends StatefulWidget {
  const TBHA({Key? key}) : super(key: key);

  @override
  _TBHAState createState() => _TBHAState();
}

class _TBHAState extends State<TBHA> {
  final amountController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final List<String> fromAccount = [
      '1000388061-SR-Curent',
      '1000388062-USD-Curent',
      '1000388063-YR-Curent',
    ];
    final List<String> toAccount = [
      '1000388061-SR-Curent',
      '1000388062-USD-Curent',
      '1000388063-YR-Curent',
    ];
    String? selectedValue = fromAccount[0];
    String? selectedValue2 = toAccount[1];




    final transferButton = GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          print(selectedValue);
          print(selectedValue2);

          print(amountController.text);
        }
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
        selectedValue = value.toString();
        // setState((){
        //   toAccount.remove(value.toString());
        //
        //   selectedValue2 = toAccount[0];
        // });
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
        centerTitle: true,
        title: Text(
          'Electricity',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(120, 148, 150, 0.8),
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
