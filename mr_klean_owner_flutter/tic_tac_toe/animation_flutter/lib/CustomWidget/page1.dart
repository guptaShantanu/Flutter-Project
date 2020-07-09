import 'package:animationflutter/CustomWidget/part1.dart';
import 'package:animationflutter/CustomWidget/part2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  final key = ValueKey(1);
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Widget currentWidget = Part1();
  bool right = null;
  bool p = true;

  String text1="Menu 1 !",text2 = "Menu2";

  static TextStyle highLightStyle = TextStyle(fontSize:15.0,fontWeight: FontWeight.w900,shadows: [Shadow(
      color: Colors.blue,
      blurRadius: 2.0
  )]);
  static TextStyle normalTextStyle = TextStyle(fontSize:15.0,fontWeight: FontWeight.w700,);
  TextStyle ts1 = highLightStyle,ts2 = normalTextStyle;




  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        right = false;
                        setState(() {
                          ts1 = highLightStyle;
                          ts2 = normalTextStyle;
                          text2 = "Menu 2";
                          text1 = "Menu 1 !";
                          currentWidget = Part1();
                        });
                        print('hello');
                      },
                      child: Container(
                        width: 10.0,
                        height: 20.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(text1,style: ts1,),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        right = true;
                        print('fir hello');
                        setState(() {
                          ts2 = highLightStyle;
                          ts1 = normalTextStyle;
                          text2 = "Menu 2 !";
                          text1 = "Menu 1";
                          currentWidget = Part2();
                        });
                      },
                      child: Container(
                        width: 10.0,
                        height: 20.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(text2,style: ts2,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child:AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: currentWidget,
              transitionBuilder: (child,animation){
                final fromRightAnimation = Tween<Offset>(begin: Offset(1,0),end: Offset(0,0)).animate(animation);
                final fromLeftAnimation = Tween<Offset>(begin: Offset(-1,0),end: Offset(0,0)).animate(animation);
                final toLeftAnimation = Tween<Offset>(begin: Offset(0,0),end: Offset(-1,0)).animate(animation);
                final toRightAnimation = Tween<Offset>(begin: Offset(0,0),end: Offset(1,0)).animate(animation);
                print(child.key);

                if(right == null){
                  return ClipRect(
                    child: SlideTransition(
                      position: fromLeftAnimation,
                      child: child,
                    ),
                  );
                }

                  if(child.key == ValueKey(11)){
                    print("go");
                    return ClipRect(
                      child: SlideTransition(
                        position: fromLeftAnimation,
                        child: child,
                      ),
                    );
                  }else{
                    print("out");
                    return ClipRect(
                      child: SlideTransition(
                        position: fromRightAnimation,
                        child: child,
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );

  }
}
