import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercalculator/screens/calculatorScreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'images/calci.png',
                      height: 150.0,
                    ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Hero(
                  tag: 'text',
                  child: Text(
                    'Calculator',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 10.0,
                  shadowColor: Colors.grey,
                  color: Colors.blueGrey.shade900,
                  child: MaterialButton(
                    height: 20.0,
                    child: Text('Go'),
                    onPressed: () {
                      Navigator.of(context).push(new SecondPageRoute());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPageRoute extends CupertinoPageRoute{
  SecondPageRoute()
  : super(builder: (BuildContext context)=>new Calculator());
  
  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return new FadeTransition(opacity: animation,child: new Calculator(),);
  }
  
}
