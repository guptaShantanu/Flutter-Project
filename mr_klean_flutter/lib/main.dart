import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';

void main() {
  runApp(LaundryApp());
}

class LaundryApp extends StatefulWidget {
  @override
  _LaundryAppState createState() => _LaundryAppState();
}

class _LaundryAppState extends State<LaundryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
