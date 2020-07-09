import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      appBar: AppBar(
        title:Text("I Am Poor"),
        centerTitle: true,
        backgroundColor: Colors.red[100],

      ),
      body: Center(
        child: Image(
          image: AssetImage('images/poor.png'),
        ),
      ),
    ),
  ));
}
