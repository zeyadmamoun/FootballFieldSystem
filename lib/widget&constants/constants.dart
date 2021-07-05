import 'package:flutter/material.dart';

var kcolor1 = Color(0xff475bd8);
var kcolor2 = Color(0xff1dd3b0);



var ktextStyle1 = TextStyle(
  color: Colors.teal,
  fontSize: 35.0,
  fontWeight: FontWeight.bold,
);

 final Shader klinearGradient = LinearGradient(
  colors: <Color>[Colors.blue, Colors.teal,],
).createShader(Rect.fromLTWH(0.0, 0.0, 70.0, 70.0));

 var appBarStyle = Container(
   decoration: BoxDecoration(
     gradient: LinearGradient(
       colors: [Colors.teal, Colors.blue], stops: [0.5, 1.0],
     ),
   ),
 );