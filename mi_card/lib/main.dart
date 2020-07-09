import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('images/shantanu.jpg'),
                ),
                Container(
                  height: 20.0,
                ),
                Text(
                  'Shantanu Gupta',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Pacifico'),
                ),
                Container(
                  height: 7.0,
                ),
                Text(
                  'Flutter developer',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2.5,
                  ),
                ),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.0,
                  indent: 80.0,
                  endIndent: 80.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 35.0,
                  color: Colors.teal,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    title: Text(
                      '+91 7991373447',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Card(
                  elevation: 35.0,
                  color: Colors.teal,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    title: Text(
                      'shantanu@gmail.com',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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
