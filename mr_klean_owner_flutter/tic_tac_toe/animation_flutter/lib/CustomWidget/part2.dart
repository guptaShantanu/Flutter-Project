import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Part2 extends StatefulWidget{
  final key = ValueKey(22);
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<Part2>  with SingleTickerProviderStateMixin {


  AnimationController animationController;
  Animation animation;
  bool bottom = false;
  Timer t;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =AnimationController(
        vsync:this ,
        duration: Duration(milliseconds: 1500)
    );

    animation = new CurvedAnimation(parent: animationController, curve: Curves.linear,);
    animationController.forward(from: 0.0,);
    startAnimation();
    t =Timer.periodic(Duration(milliseconds: 1500), (timer) {
      if(bottom){
        animationController.forward(from: 0.0);
        bottom = false;
      }else{
        animationController.reverse(from: 1.0);
        bottom = true;
      }
    });
  }
  void startAnimation(){
    animation.addListener(() {
        setState(() {

        });
//        print(animation.value);
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    t.cancel();
    animation.removeListener(() { });
    animationController.dispose();
    super.dispose();

//    animationController.removeListener(() { });
//    animation.isCompleted = true;
//    animationController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 350.0,
            padding: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 5.0,offset: Offset(5,5),)],
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 150.0,
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    margin: EdgeInsets.only(top: 50*animation.value),
                    child: Image(
                      image: AssetImage('images/cofee.png'),
                    ),
                  ),
                ),
                SizedBox(height: 5.0,),
                ClipOval(
                  child: Container(
                    height: 10.0,
                    width: 30.0+30*animation.value,

                    decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 3.0,color: Colors.blueGrey)]
                    ),
                  ),
                ),
                SizedBox(height:20.0),
                Text('Buy  me  a',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
                SizedBox(height: 5.0,),
                Text('Coffee',style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  shadows: [Shadow(color: Colors.blue,blurRadius: animation.value*15.0,)]
                ),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
