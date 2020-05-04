import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyClock());
}

class MyClock extends StatefulWidget {
  @override
  _MyClockState createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> with TickerProviderStateMixin {
  double pi = 3.14;
  double angle = 0, angle2 = 0, angle3 = 0, angle4=0,angle5=3.14/2;
  double add = 0.1333333333;
  int seconds = 0, minutes = 0;
  bool fliped = false;

  //Animation ka saman
  Animation animation,animation2;
  AnimationController controller,controller2;

  void startFirstPageAnimation() {
    if(!fliped){
      controller.forward(from: 0.0);
      animation.addListener(() {
        setState(() {
          angle4 = (pi/180)*animation.value*90;
        });
//        print(angle4);
        if(animation.value==1.0 && fliped==false){
          startSecondPageAnimation();
        }
      });
    }else{
      controller.reverse(from: 1.0);
      animation.addListener(() {
        setState(() {
          angle4 = (pi/180)*animation.value*90;
        });
      });
      fliped=false;
    }
  }

  void startSecondPageAnimation(){
    if(!fliped){
      controller2.reverse(from: 1.0);
      animation2.addListener(() {
        setState(() {
          angle5 = (pi/180)*animation2.value*90;
        });
//        print(angle4);
      });
      fliped = true;
    }else{
      controller2.forward(from: 0.0);
      animation2.addListener(() {
        setState(() {
          angle5 = (pi/180)*animation2.value*90;
        });
        if(animation2.value==1.0 &&  fliped==true){
          startFirstPageAnimation();
        }
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Animation Initialization
    //upper page
    controller =
    new AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    controller.forward(from: 0);
    animation =
    new CurvedAnimation(parent: controller, curve: Curves.linear);

    //bottom page
    controller2 =
    new AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation2 =
    new CurvedAnimation(parent: controller2, curve: Curves.linear);

    int hour = DateTime.now().hour;
    int minute = DateTime.now().minute;
    angle2 = minute.toDouble() * (pi / 30);
    if (hour < 12) {
      angle3 = (hour.toDouble()) * (pi / 30) * 5;
    } else {
      angle3 = (hour.toDouble() - 12) * (pi / 30) * 5;
    }
    if (minute >= 12) {
      angle3 += ((pi / 30) * ((minute / 12).toInt()));
      minutes = minute % 12;
    } else {
      minutes = minute;
    }
//    print("Initial minute " + minutes.toString());

    setState(() {
      angle3 = angle3;
      angle2 = angle2;
    });

    startClock();
  }



  void startClock() async {
    seconds += 1;
    setState(() {
      angle += pi / 30;

      if (seconds == 60) {
        seconds = 0;
        angle2 += pi / 30;
        minutes += 1;
      }
      if (minutes == 12) {
        minutes = 0;
        angle3 += (pi / 30);
      }
    });
//    print(angle);
//    print("Minutes" + minutes.toString());

    new Future.delayed(Duration(seconds: 1), () {
      startClock();
    });
  }

  Future sleep() {
    return new Future.delayed(Duration(seconds: 1), () => "1");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Start animation called");
            fliped?startSecondPageAnimation():startFirstPageAnimation();
          },
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 30.0),
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                    ],
                  ),
                ),
                Container(
                  height: 200.0,
                  width: 200.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3.0,
                            color: Colors.black54,
                            offset: Offset.zero)
                      ]),
                  child: Image.asset("images/clock.png"),
                ),
                //Seconds stick
                Transform.rotate(
                  angle: angle,
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(110.0),
                        color: Colors.transparent),
                    child: Container(
                        margin: EdgeInsets.only(top: 5.0),
                        height: 120.0,
                        width: 2.0,
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 3.0,
                              backgroundColor: Colors.black,
                            ),
                            CircleAvatar(
                              radius: 3.0,
                              backgroundColor: Colors.black,
                            ),
                          ],
                        )),
                  ),
                ),
                // Minutes stick
                Transform.rotate(
                  angle: angle2,
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      height: 100.0,
                      width: 5.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Hour Stick
                Transform.rotate(
                  angle: angle3,
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110.0),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 30.0),
                      height: 70.0,
                      width: 7.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
