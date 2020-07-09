import 'dart:ui';

import 'package:bmi_calc/CardView.dart';
import 'package:bmi_calc/bottom_button.dart';
import 'package:bmi_calc/input_page.dart';
import 'package:bmi_calc/main.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'input_page.dart';



class Result_Page extends StatelessWidget {

  String result;
  String bmi;
  String inerpretation;

  Result_Page({this.result,this.bmi,this.inerpretation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 50.0,left: 10.0),
                child: Text('YOUR RESULT',
                style: bigTextStyle,
                ),
              ),

            ),
          Expanded(
            flex: 5,
            child: CardView(color: active,childcard: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(result.toUpperCase(),
                style: resultHeadStyle,
                textAlign: TextAlign.center,),
                Text(bmi,
                style: bmiResultStyle,
                textAlign: TextAlign.center,),
                Text(inerpretation,
                style: bmiResultTextStyle,
                textAlign: TextAlign.center,)
              ],
            ),
            ),
          ),
          Expanded(
            child: BottomButton(title: 'RE-CALCULATE',onTap: (){
              Navigator.pop(context);
            },),
          )
        ],
      ),
    );
  }
}
