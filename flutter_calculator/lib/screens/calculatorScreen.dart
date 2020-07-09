import 'dart:ui' ;
import 'package:flutter/material.dart';
import 'package:fluttercalculator/calculation.dart';
import 'package:fluttercalculator/history_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttercalculator/screens/historyScreen.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expression = "",prevExp="";

  bool decimal = false;
  void btnPress(String symbol) {
    if(expression.length <=18){
      if (symbol == '+' || symbol == '-' || symbol == '*' || symbol == '/') {
        if (expression == "0" && symbol == "-") {
          expression = '-';
        } else {
          String current = expression[expression.length - 1];
          if (expression.length > 0 &&
              (current == "+" ||
                  current == "-" ||
                  current == "*" ||
                  current == "/")) {
            String temp = expression.substring(0, expression.length - 1);
            temp = temp + symbol;

            expression = temp;
            decimal=false;
          } else if (expression.length > 0) {
            expression += symbol;
            decimal=false;
          }
        }
      } else if (symbol == '.') {
        if (decimal == false) {
          expression += '.';

          decimal = true;
        }
      } else if (symbol == '=') {
        var result = getResult(expression);
        expressions.add(expression);
        prevExp=expression;
        results.add(result);
        setState(() {
          expression=result;
          prevExp+="";
        });
      } else {
        expression += symbol;
      }
      setState(() {
        expression=expression+"";
      });
    }else if(symbol == "="){
      var result = getResult(expression);
      expressions.add(expression);
      results.add(result);
      setState(() {
        prevExp=expression;
        expression=result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 5.0,
          width: 5.0,
          child: Hero(tag:'logo',child: Image.asset('images/calci.png',height: 5.0,width: 5.0,)),
        ),
        title: Hero(tag:'text',child: Text('Calculator')),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () async{
              var resp = await Navigator.push(context, MaterialPageRoute(builder: (context){
                return HistoryScreen();
              }));
              if(resp!=null){
                setState(() {
                  prevExp=resp[0];
                  expression=resp[1];

                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  
                  Text(
                    prevExp,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 1.0,
                    child: Container(
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    expression,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 1.0,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new CalciButton(Colors.red, 'C', () {
                  setState(() {
                    expression="";
                  });
                  decimal=false;
                }),
                new CalciButton(Colors.blue, '<=', () {
                  if(expression[expression.length-1]=='.'){
                    decimal=false;
                  }
                  setState(() {
                    expression=expression.substring(0,expression.length-1);
                  });
                }),

              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new CalciButton(Colors.blueGrey.shade800, '1', () {
                  btnPress('1');
                }),
                new CalciButton(Colors.blueGrey.shade800, '2', () {
                  btnPress('2');
                }),
                new CalciButton(Colors.blueGrey.shade800, '3', () {
                  btnPress('3');
                }),
                new CalciButton(Colors.blueGrey.shade900, '+', () {
                  btnPress('+');
                }),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new CalciButton(Colors.blueGrey.shade800, '4', () {
                  btnPress('4');
                }),
                new CalciButton(Colors.blueGrey.shade800, '5', () {
                  btnPress('5');
                }),
                new CalciButton(Colors.blueGrey.shade800, '6', () {
                  btnPress('6');
                }),
                new CalciButton(Colors.blueGrey.shade900, '-', () {
                  btnPress('-');
                }),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new CalciButton(Colors.blueGrey.shade800, '7', () {
                  btnPress('7');
                }),
                new CalciButton(Colors.blueGrey.shade800, '8', () {
                  btnPress('8');
                }),
                new CalciButton(Colors.blueGrey.shade800, '9', () {
                  btnPress('9');
                }),
                new CalciButton(Colors.blueGrey.shade900, 'x', () {
                  btnPress('*');
                }),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new CalciButton(Colors.blueGrey.shade800, '.', () {
                  btnPress('.');
                }),
                new CalciButton(Colors.blueGrey.shade800, '0', () {
                  btnPress('0');
                }),
                new CalciButton(Colors.blue, '=', () {
                  btnPress('=');
                }),
                new CalciButton(Colors.blueGrey.shade900, '/', () {
                  btnPress('/');
                }),
              ],
            ),
          ),

        ],
      )),
    );
  }
}

class CalciButton extends StatelessWidget {
  Color color;
  String icon;
  Function function;
  CalciButton(this.color, this.icon, this.function);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color,
        ),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          height: 100.0,
          child: MaterialButton(
            child: Text(
              icon,
              style: TextStyle(fontSize: 50.0, color: Colors.white),
            ),
            onPressed: function,
          )),
    );
  }
}
