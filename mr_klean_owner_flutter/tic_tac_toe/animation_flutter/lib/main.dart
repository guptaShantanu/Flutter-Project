import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomWidget/page1.dart';
import 'CustomWidget/page2.dart';
import 'CustomWidget/page3.dart';
import 'Screens/Animation2.dart';
import 'Screens/Animation3.dart';

void main() {
  runApp(Animation3());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentWidget = Page1();
  int currentIndex = 1;
  bool bottom = true;
  bool p = true;
  static Color KBackgroundColor = Color.fromRGBO(239, 238, 238, 1);


  String text1 = "Option 1 !",text2 = "Option 2",text3 = "Option 3";
  static TextStyle highLightStyle = TextStyle(fontSize:15.0,fontWeight: FontWeight.w900,shadows: [Shadow(
      color: Colors.blue,
      offset: Offset(2,2),
      blurRadius: 4.0
  )]);
  static TextStyle normalTextStyle = TextStyle(fontSize:15.0,fontWeight: FontWeight.w700,);
  TextStyle ts1 = highLightStyle,ts2 = normalTextStyle,ts3 = normalTextStyle;


  List<Color> _fill = <Color>[
    Color.fromRGBO(245, 245, 245, 1),
    KBackgroundColor,
    Color.fromRGBO(245, 245, 245, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: KBackgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 200.0,
                      margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                      padding: EdgeInsets.only(top: 25.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _fill,
                              stops: [0.1, 0.5, 0.9]),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(216, 213, 208, 1),
                              offset: Offset(5.0, 5.0),
                              blurRadius: 15.0,
                            ),
                            BoxShadow(
                              color: KBackgroundColor,
                              offset: Offset(-5.0, -5.0),
                              blurRadius: 15.0,
                            )
                          ]),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 70.0,
                                width: 70.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2.0,
                                        offset: Offset(1, 1),
                                        color: Colors.blueGrey)
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://images.unsplash.com/photo-1507430989479-54824c2ed9d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                                  ),

//                borderRadius: BorderRadius.circular(30.0)
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Monali thakur',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Flutter Developer | Foodie | Ukraine',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    '124',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    'Posts',
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12.0),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '10.3K',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12.0),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '14',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  bottom = false;

                                  setState(() {
                                    text1 = 'Option 1 !';
                                    text2 = 'Option 2';
                                    text3 = 'OPtion 3';
                                    ts1 = highLightStyle;
                                    ts2 = normalTextStyle;
                                    ts3 = normalTextStyle;
                                    currentWidget = Page1();
                                  });
                                  currentIndex = 1;

                                },
                                child: Container(
                                  height: 70.0,
                                  width: 70.0,
                                  alignment: Alignment.center,
                                  child: Transform.rotate(
                                    angle: -3.14 / 2,
                                    child: Text(text1,style: ts1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  bottom = true;

                                  setState(() {
                                    text2 = 'Option 2 !';
                                    text1 = 'Option 1';
                                    text3 = 'OPtion 3';
                                    ts2 = highLightStyle;
                                    ts1 = normalTextStyle;
                                    ts3 = normalTextStyle;
                                    currentWidget = Page2();
                                  });
                                  currentIndex = 2;

                                },
                                child: Container(
                                  height: 70.0,
                                  width: 70.0,
                                  alignment: Alignment.center,
                                  child: Transform.rotate(
                                    angle: -3.14 / 2,
                                    child: Text(text2,style: ts2),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  bottom = true;
                                  currentIndex = 3;

                                  setState(() {
                                    text3 = 'Option 3 !';
                                    text1 = 'Option 1';
                                    text2 = 'OPtion 2';
                                    ts3 = highLightStyle;
                                    ts1 = normalTextStyle;
                                    ts2 = normalTextStyle;
                                    currentWidget = Page3(color: Colors.yellow,);
                                  });
                                },
                                child: Container(
                                  height: 70.0,
                                  width: 70.0,
                                  alignment: Alignment.center,
                                  child: Transform.rotate(
                                    angle: -3.14 / 2,
                                    child: Text(text3,style: ts3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: currentWidget,
                            transitionBuilder: (child,animation){
                              final fromUpAnimation = Tween<Offset>(begin: Offset(0,1),end: Offset(0,0)).animate(animation);
                              final fromDownAnimation = Tween<Offset>(begin: Offset(0,-1),end: Offset(0,0)).animate(animation);
                              print(child.key);

                              if(child.key == ValueKey(1)){
                                  print("fromUp");
                                  return ClipRect(
                                    child: SlideTransition(
                                      position: fromDownAnimation,
                                      child: child,
                                    ),
                                  );
                              }else{
                                print("fromDown");
                                return ClipRect(
                                  child: SlideTransition(
                                    position: fromUpAnimation,
                                    child: child,
                                  ),
                                );
                              }
                            },

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
