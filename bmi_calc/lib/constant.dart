import 'package:flutter/material.dart';

Color inActive=Colors.blueGrey.shade900;
Color active=Colors.blueGrey.shade800;
int height=120;
int weight=50;
int age=10;

enum Gender { male, female }

TextStyle smallTextStyle=TextStyle(
    fontSize: 18.0,
    color: Color(0xFF8D8E98)
);

TextStyle bigTextStyle=TextStyle(
    fontSize: 40.0,
    color: Colors.white,
    fontWeight: FontWeight.w900
);

TextStyle resultHeadStyle=TextStyle(
    fontSize: 20.0,
    color: Colors.green.shade600,
    fontWeight: FontWeight.w900
);

TextStyle bmiResultStyle=TextStyle(
    fontSize: 100.0,
    color: Colors.white,
    fontWeight: FontWeight.w900
);

TextStyle bmiResultTextStyle=TextStyle(
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.w900
);