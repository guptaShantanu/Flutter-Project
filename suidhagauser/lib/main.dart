import 'package:flutter/material.dart';
import 'package:user/screens/home_screen.dart';
import 'package:user/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Sui Dhaga',
      initialRoute: WelcomeScreen.route,
      routes: {
        WelcomeScreen.route: (context) => WelcomeScreen(),
        HomeScreen.route: (context) => HomeScreen(),
      },
    );
  }
}
