import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  int imageNum = 1;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magic Ball'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade600,
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('images/ball$imageNum.png'),
              )
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: FloatingActionButton(
                hoverColor: Colors.red,
                highlightElevation: 20.0,
                backgroundColor: Colors.blueGrey.shade900,
                child: Text('?',
                style: TextStyle(
                  color: Colors.white,
                ),),
                onPressed: () {
                  setState(() {
                    imageNum = Random().nextInt(5) + 1;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
