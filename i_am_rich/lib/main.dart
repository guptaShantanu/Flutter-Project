import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blueGrey[600],
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                Image(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                )
              ],
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text('I Am Rich'),
            backgroundColor: Colors.blueGrey[900],
          ),
          body: Center(
            child: Image(
              image: AssetImage('images/diamond.png'),
            ),
          )),
    ),
  );
}
