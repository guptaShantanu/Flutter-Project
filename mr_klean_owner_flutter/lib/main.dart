import 'package:mrkleanownerflutter/screens/add_screen.dart';
import 'package:mrkleanownerflutter/screens/login_screen.dart';
import 'package:mrkleanownerflutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(OwnerApp());
}

class OwnerApp extends StatefulWidget {
  @override
  _OwnerAppState createState() => _OwnerAppState();
}

class _OwnerAppState extends State<OwnerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
