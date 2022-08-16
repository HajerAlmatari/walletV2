import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {

  final IconData icon;
  final String text;
  const CustomListTile({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey,),
          const SizedBox(width: 15.0,),
          Text("$text", style: const TextStyle(fontSize: 16.0),),
        ],
      ),
    );
  }
}
