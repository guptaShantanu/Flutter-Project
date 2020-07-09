import 'package:flutter/material.dart';
import 'constant.dart';

class BottomButton extends StatelessWidget {
final Function onTap;
final String title;

BottomButton({@required this.title,@required this.onTap});

final double containerHeight=80.0;

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      child: Center(child: Text(title,
        style: bmiResultTextStyle,)),
      height: containerHeight,
      margin: EdgeInsets.symmetric(vertical:6.0,horizontal: 8.0),
      width: double.infinity,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(6.0),
        color: Colors.red,),

    ),
  );
}
}