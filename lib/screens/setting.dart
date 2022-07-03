import 'package:flutter/material.dart';
import 'package:walletapp/screens/nav_screen.dart';

import '../constants.dart';
import '../widgets/list_tile.dart';
import 'lang.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool turnOnNotification = false;
  bool turnFingerprint = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          backgroundColor: CDarkerColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavScreen()),
              );

            },
            /*onPressed: ()=>Navigator.of(context).pop(),*/
          )),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: .0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3.0,
                            offset: Offset(0, 4.0),
                            color: Colors.black12,
                          )
                        ],
                        image: DecorationImage(
                            image: AssetImage("assets/icons/avatar_3.png"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(width: 30.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Abdulaziz Alshami", style: TextStyle(fontSize: 16.0),),
                      SizedBox(height: 10,),
                      Text("775 553 281", style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 20.0,),
                      Container(
                        height: 25.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(child: Text("Edit", style: TextStyle(color: Colors.black, fontSize: 16),),),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30.0,),
              Text("Account", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomListTile(icon: Icons.location_on, text: "Location: Nearest ATM"),
                      Divider(height: 10.0, color: Colors.grey,),
                      CustomListTile(icon: Icons.visibility, text: "Change Password"),
                      Divider(height: 10.0, color: Colors.grey,),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "App Notification",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Switch(
                            value: turnOnNotification,
                            onChanged: (bool value) {
                              setState(() {
                                turnOnNotification = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fingerprint Activation",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Switch(
                            value: turnFingerprint,
                            onChanged: (bool value) {
                              setState(() {
                                turnFingerprint = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Other",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                LanguageScreen()
                              ));
                        }, child:
                        Text(
                          "Language",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),),
                        //SizedBox(height: 10,),
                        Divider(
                          height: 30,
                          color: Colors.grey,
                        ),
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        //SizedBox(height: 10,),
                        Divider(
                          height: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
