import 'package:flutter/material.dart';


class CardView extends StatelessWidget {
  final Color color;
  final Widget childcard;
  Function onPress;
  CardView({@required this.color, this.childcard,this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: childcard,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}