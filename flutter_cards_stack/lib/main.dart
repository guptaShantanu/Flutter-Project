import 'package:flutter/material.dart';
import 'package:flutter_stack_card/flutter_stack_card.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> nameList=['Shantanu','Tanu','Pawan','Mohit','Yash','Nivedita'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: 300.0,
            color: Colors.white,
            width: 300.0,
            padding: EdgeInsets.all(10.0),

            alignment: Alignment.center,
            child: StackCard.builder(
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.all(10.0),
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text(nameList[index]),
                );
              },
              itemCount: nameList.length,
              displayIndicator: true,
              displayIndicatorBuilder: IdicatorBuilder(displayIndicatorActiveColor: Colors.blue,displayIndicatorSize: 5.0),
              onSwap: (index){
                print(index);
              },

            ),
          ),
        ),
      ),
    );
  }
}
