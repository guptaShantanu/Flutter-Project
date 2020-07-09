import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final String hint;
  final Function onChangeFunction;
  final IconData icon;
  final isActive;
  final textController;

  MyTextField({this.hint,this.icon=Icons.add,this.onChangeFunction,this.isActive=true,this.textController=null});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: isActive,
      controller: textController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          fontSize: 15.0, color: Colors.lightBlueAccent),
      cursorColor: Colors.lightBlueAccent,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          hintText: hint,
          suffixIcon: Icon(icon,color: Colors.lightBlueAccent,)),
      onChanged: onChangeFunction,
    );
  }
}