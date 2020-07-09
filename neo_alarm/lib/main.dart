import 'package:flutter/material.dart';
import 'package:neoalarm/Screens/mainScreen.dart';
import 'package:neoalarm/Screens/welcomeScreen.dart';
import 'package:provider/provider.dart';

import 'Modal/alarmList.dart';

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
    return ChangeNotifierProvider(
      create: (context){
        return AlarmList();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}
