import 'package:flutter/material.dart';

Widget CarouselWidget (int length, int selected)
{
  return Container(
    margin: EdgeInsets.only(top: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        if (index == selected)
          return Container(
            width: 40.0,
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient:LinearGradient(
              colors: [Color.fromRGBO(120, 148, 150, 0.8), Colors.black54],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            ),
              );
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          child: CircleAvatar(radius: 5,backgroundColor: Colors.grey,),
        );
    },).reversed.toList()
    ),
  );
}

