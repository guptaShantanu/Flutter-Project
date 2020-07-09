import 'package:flutter/material.dart';
import 'package:urbanridertest/Screens/notification_testing_screen.dart';
import 'Screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationScreen(),
    );
  }
}
