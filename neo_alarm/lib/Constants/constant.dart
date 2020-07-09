import 'package:flutter/material.dart';

const KBackgroundColor = Color.fromRGBO(239, 238, 238, 1);

const List<Color> _fill = <Color>[
  Color.fromRGBO(245, 245, 245, 1),
  KBackgroundColor,
  Color.fromRGBO(245, 245, 245, 1),
];


const kConcaveButtonShadow = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(50)),
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: _fill,
    stops: [0.1, 0.5, 0.9],
  ),
);

const  kNeoBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(216, 213, 208, 1),
      offset: Offset(5.0, 5.0),
      blurRadius: 15.0,
    ),
    BoxShadow(
      color: Colors.blueGrey,
      offset: Offset(-5.0, -5.0),
      blurRadius: 5.0,
    )
  ],
);

const  kBottomIconWhiteDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(216, 213, 208, 1),
      offset: Offset(5.0, 5.0),
      blurRadius: 15.0,
    ),
    BoxShadow(
      color: Colors.blueGrey,
      offset: Offset(-5.0, -5.0),
      blurRadius: 5.0,
    )
  ],
);

const  kBottomIconGrayDecoration = BoxDecoration(
  color: Colors.blueGrey,
  borderRadius: BorderRadius.all(Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(216, 213, 208, 1),
      offset: Offset(5.0, 5.0),
      blurRadius: 15.0,
    ),
    BoxShadow(
      color: Colors.blueGrey,
      offset: Offset(-5.0, -5.0),
      blurRadius: 5.0,
    )
  ],
);


const  kStopWatchControllerButton = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(216, 213, 208, 1),
      offset: Offset(5.0, 5.0),
      blurRadius: 15.0,
    ),
    BoxShadow(
      color: Colors.white,
      offset: Offset(-5.0, -5.0),
      blurRadius: 5.0,
    )
  ],
);


const kPageTitleTextStyle = TextStyle(fontFamily: 'Montserrat',fontSize: 30.0,shadows: [
  Shadow(blurRadius: 13.0,color: Colors.blueGrey,offset: Offset(4,4)),
]);


const kTitlePageTextStyle = TextStyle(fontFamily: 'Montserrat',fontSize: 40.0,shadows: [
  Shadow(blurRadius: 13.0,color: Colors.blueGrey,offset: Offset(4,4)),
]);

const kAlarmTitleTextStyle = TextStyle(fontFamily: 'Montserrat',fontSize: 20.0,shadows: [
  Shadow(blurRadius: 13.0,color: Colors.blueGrey,offset: Offset(4,4)),
]);