import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/Screens/task_screen.dart';
import 'package:todoey/Screens/test_screen.dart';
import 'package:todoey/list.dart';

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
        return TasksList();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}
