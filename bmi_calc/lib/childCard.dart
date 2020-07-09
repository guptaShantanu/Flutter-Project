import 'package:flutter/material.dart';


class ChildCard extends StatelessWidget {
  final IconData icon;
  final String label;
  ChildCard({@required this.icon,@required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
          size: 70.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 18.0, color: Color(0xFF8D8E98)),
        )
      ],
    );
  }
}