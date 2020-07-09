import 'package:flutter/material.dart';
import 'package:neoalarm/Constants/constant.dart';

class WelcomeScreenCard extends StatelessWidget {
  final leftMargin;
  final topMargin;
  final image;

  const WelcomeScreenCard({
    this.leftMargin,
    this.topMargin,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      margin: EdgeInsets.only(top: topMargin,left: leftMargin),
      decoration: kNeoBoxDecoration,
      padding: EdgeInsets.all(15.0),
      child: Image.asset(image),
    );
  }
}