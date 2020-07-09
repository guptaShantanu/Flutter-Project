import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<Part2> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation animation;

  List<Offset> waveRectList = [];

  var sinWave;






  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    animationController = AnimationController(vsync: this,duration: Duration(seconds: 60));
    animationController.addListener(() {

    });

    animation = Tween(
      begin: 0.0,
      end:Math.pi*20
    ).animate(animationController)
    ..addListener(() {
      setState(() {
      });
    });


    animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        animationController.forward();
      }
    });
    animationController.forward();
    print("::::::::");
    print(animation.value);
    print("::::::::");
    for(int i =0;i<=200;i++){
      waveRectList.add(
          Offset(i.toDouble(),(Math.sin((animation.value*360-i)%360*(Math.pi/180))*20))
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100.0,
          color: Colors.red,
        ),
        clipper:new WaveClipper(
          animationValue: animation.value,
          waveList: waveRectList
        ),
      )
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;
  List<Offset> waveList = [];
  WaveClipper({this.animationValue,this.waveList});


  @override
  getClip(Size size) {
    // TODO: implement getClip
    Path path = new Path();

    path.addPolygon(waveList, false);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
//    return animationValue != oldClipper.animationValue;
  return false;
  }
}
