import 'package:flutter/material.dart';
import 'package:fluttercalculator/screens/calculatorScreen.dart';
import 'package:fluttercalculator/screens/historyScreen.dart';
import 'package:fluttercalculator/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white)
        )
      ),
      initialRoute: 'welcome_screen',
      routes: {
        'calculator_screen':(context)=>Calculator(),
        'history_screen':(context)=>HistoryScreen(),
        'welcome_screen':(context)=>WelcomeScreen(),
      },
    );
  }
}
