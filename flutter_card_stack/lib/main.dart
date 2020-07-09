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
            alignment: Alignment.center,
            child: StackCard.builder(
                itemBuilder: (context,index){
                  return Container(
                    alignment: Alignment.center,
                    height: 100.0,
                    width: 100.0,
                    child: Text(nameList[index]),
                  );
                },
                itemCount: nameList.length,
                displayIndicatorBuilder: IdicatorBuilder(displayIndicatorActiveColor: Colors.red,),
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
