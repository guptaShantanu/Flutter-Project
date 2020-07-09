import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNum = 1;
  int rightDiceNum= 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
            child: Image.asset('images/dice$leftDiceNum.png'),
            onPressed: () {
                changeDice();
            },
          ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FlatButton(
                child: Image.asset('images/dice$rightDiceNum.png'),
                onPressed: () {
                  changeDice();
                },
              ),
            ),
          )
        ],
      ),
    );
  }


  void changeDice(){
    setState(() {
      rightDiceNum=Random().nextInt(6)+1;
      leftDiceNum=Random().nextInt(6)+1;

    });
  }
}
