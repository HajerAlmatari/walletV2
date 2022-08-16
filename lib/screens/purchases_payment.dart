import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:walletapp/Models/SubAccount.dart';
import 'package:walletapp/Models/SubAccountNumbers.dart';
import '../widgets/InputField.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class PurchasesPayment extends StatefulWidget {
  const PurchasesPayment({Key? key}) : super(key: key);

  @override
  _PurchasesPaymentState createState() => _PurchasesPaymentState();
}

class _PurchasesPaymentState extends State<PurchasesPayment> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // @override
  // void reassemble() {
  //   super.reassemble();
  //
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // result = scanData;
        result = scanData;

        if (result != null) {
          sellerNumber.text = result!.code.toString();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // ===========================================
  // ===========================================
  // ===========================================

  final amountController = TextEditingController();
  final sellerNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    // SubAccountNumbers subAccountNumbers= new SubAccountNumbers();
    // final  List<SubAccount> subAccountsList= subAccountNumbers.getSubAccountList();
    final List<String> fromAccount = [
      "1111111",
      "2222222",
      "3333333",
    ];
    // for(var subaccount in subAccountsList){
    //   fromAccount.add(subaccount.id.toString()+"-"+subaccount.currencyType);
    // }
    String selectedValue = fromAccount[0];

    final transferButton = GestureDetector(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          EasyLoading.show(status: 'Loading ...');

          EasyLoading.dismiss();
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
              fontWeight: FontWeight.bold,
            ),
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
        style:const TextStyle(fontSize: 14),
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
        title: const Text(
          'Transfer to Name',
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
                sellerNumber,
                TextInputType.text,
                'Seller Number',
                false,
                suffixIcon: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Scan the wallet QR"),
                        content: SizedBox(
                          height: 200,
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(amountController, TextInputType.number,
                  'Enter the amount', false,
                  suffixIcon: const Icon(Icons.money)),
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
