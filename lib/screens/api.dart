import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Api/RemoteService.dart';

class APIScreen extends StatefulWidget {
  const APIScreen({Key? key}) : super(key: key);

  @override
  _APIScreenState createState() => _APIScreenState();
}
String? stringResponse ;
Map? mapResponse;
String name=" ";
class _APIScreenState extends State<APIScreen> {
  /*Future apicall() async{
    http.Response response;
    response=await http.get(Uri.parse("https://reqres.in/api/users/2"));
    if(response.statusCode ==200){
      setState(() {
        //stringResponse = response.body;
        mapResponse = json.decode(response.body);
        print("Hello"+mapResponse.toString());
      });
    }
  }*/
  @override
  void initState(){
   //   apicall();
      super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
         child:  Text(name,style: TextStyle(fontSize: 30),),
      ),
    );
  }


}
