import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function onTap;

  MyButton({this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 70.0),
        height: 50.0,
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1.0),
            border: Border.all(
                color: Colors.lightBlueAccent,
                width: 4.0
            ),
            boxShadow: [BoxShadow(blurRadius: 4.0,color: Colors.black)],
            borderRadius: BorderRadius.circular(30.0)
        ),
        child: Text(title,style: TextStyle(fontSize: 20.0,color: Colors.lightBlueAccent),),
      ),
    );
  }
}