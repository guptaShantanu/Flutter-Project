import 'package:flutter/material.dart';
import 'package:fluttertoolapp/Screens/menu_screen.dart';
import 'package:fluttertoolapp/Screens/threeDscreen.dart';

void main(){
  runApp(ToolApp());
}

class ToolApp extends StatefulWidget {
  @override
  _ToolAppState createState() => _ToolAppState();
}

class _ToolAppState extends State<ToolApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MenuScreen(),
    );
  }
}

