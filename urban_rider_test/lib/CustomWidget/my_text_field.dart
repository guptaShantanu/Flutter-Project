import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final String labelText;
  final TextInputType type;
  final Function onChange;
  final TextEditingController controller;

  MyTextField({this.labelText, this.type, this.onChange, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        onChanged: onChange,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
