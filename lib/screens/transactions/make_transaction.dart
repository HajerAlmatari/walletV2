import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletapp/screens/Internet_adsl.dart';
import 'package:walletapp/screens/electricity.dart';
import 'package:walletapp/screens/transactions/my_buttons.dart';
import 'package:walletapp/screens/transfer_between_holder_accounts.dart';
import 'package:walletapp/screens/transfer_to_name.dart';
import 'package:walletapp/screens/transfer_to_other_account.dart';
import 'package:walletapp/screens/yemen_mobile.dart';

class MakeTransactionPage extends StatefulWidget {
  const MakeTransactionPage({Key? key}) : super(key: key);

  @override
  State<MakeTransactionPage> createState() => _MakeTransactionPageState();
}

class _MakeTransactionPageState extends State<MakeTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            // MyButton(iconImagePath: "images/money-transfer .png", buttonText: "YCB Express", destination: TTN(), onTap: (){print('object')},),
            MyButton(
              iconImagePath: "images/ycbExpress.svg",
              buttonText: "YCB Express\n",
              onTap: () => showModalBottomSheet(
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),

                ),
                context: context,
                builder: (context)=> buildSheet1(),
              ),
            ),

            MyButton(
              iconImagePath: "images/money-bills.svg",
              buttonText: "Payment\n",
              onTap: () => showModalBottomSheet(
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),

                ),
                context: context,
                builder: (context)=> buildSheet2(),
              ),
            ),

            MyButton(
              iconImagePath: "images/cancel.svg",
              buttonText: "Cancel \nRemittance",
              onTap: () {
                print("object");
              },
            ),
          ]),
          // const SizedBox(height: 15),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: const [
          //     MyButton(iconImagePath: "images/ecommerce.png", buttonText: "Remittance\nStatus", destination: TTN(),),
          //     MyButton(iconImagePath: "images/money-bills.png", buttonText: "Receive\nRemittance\nto Account", destination: TTN(),),
          //
          //   ],
          // )
        ],
      ),
    );
  }

  Widget buildSheet1() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        listTail(Image.asset("images/money-transfer .png",width: 50,),"Transfer Between Holder Accounts", TBHA()),
        listTail(Image.asset("images/transferToOtherAccount.png",width: 50,),"Transfer To Other Account",TTOA()),
        listTail(Image.asset("images/transferToName.png",width: 50,),"Transfer To Name", TTN()),
      ],
    ),
  );

  Widget buildSheet2() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        listTail(Image.asset("images/electricity.png",width: 50,),"Electricity", Electricity()),
        listTail(Image.asset("images/internet.png",width: 50,),"Internet ADSL",InternetADSL()),
        listTail(Image.asset("images/yemenMobile.png",width: 50,),"Yemen Mobile", YemenMobile()),
      ],
    ),
  );


  Widget listTail(Image leadingImage, String title, Widget destination){
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: leadingImage,
          title: Text(title),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>destination));
          },
        ),
      ),
    );
  }
}
