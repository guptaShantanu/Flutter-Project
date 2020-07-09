import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'constant.dart';


class Calculate{
  final int height;
  final int weight;
  final int age;
  final Gender gender;
  double _bmi;

  Calculate({@required this.gender,@required this.height,@required this.weight,@required this.age});

  findBMI(){
    _bmi=this.weight/pow(height/100,2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult(){
    if(_bmi>=25){
      return "over weight";
    }
    else if(_bmi>18.5){
      return "normal";
    }else{
      return "under weight";
    }
  }

  String getInterpretation(){
    if(_bmi>=25){
      return "jarurat se jada mote ho";
    }
    else if(_bmi>18.5){
      return "normal";
    }else{
      return "Halke ho beta";
    }
  }
}