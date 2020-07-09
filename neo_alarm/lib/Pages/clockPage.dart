import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neoalarm/Constants/constant.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {

  // Clock data
  double pi = 3.142857143;
  double angle = 0, angle2 = 0, angle3 = 0;
  double add = 0.1333333333;
  int seconds = 0, minutes = 0;
  Timer t;

  // Clock function
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int hour = DateTime.now().hour;
    int minute = DateTime.now().minute;
    int second = DateTime.now().second;
    angle = second.toDouble() * (pi/30);
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

    t = Timer.periodic(Duration(seconds: 1), (timer) {
      startClock();
    });


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

//    new Future.delayed(Duration(seconds: 1), () {
//      startClock();
//    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t.cancel();

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: KBackgroundColor,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10.0),
                child: Text('My Clock',style: kPageTitleTextStyle),
            ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: KBackgroundColor,
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
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3.0,
                              color: Colors.black54,
                              offset: Offset.zero)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5.0),
                          height: 20.0,
                          width: 7.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey,width: 2.0),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5.0),
                              height: 7.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey,width: 2.0),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              height: 7.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey,width: 2.0),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          height: 20.0,
                          width: 7.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey,width: 2.0),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.rotate(
                    angle: (pi/30)*5,
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: Colors.transparent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 7.0,
                            width: 7.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey,width: 2.0),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5.0),
                                height: 7.0,
                                width: 7.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueGrey,width: 2.0),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5.0),
                                height: 7.0,
                                width: 7.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueGrey,width: 2.0),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 7.0,
                            width: 7.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey,width: 2.0),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: (pi/30)*10,
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(110.0),
                          color: Colors.transparent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 7.0,
                            width: 7.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey,width: 2.0),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5.0),
                                height: 7.0,
                                width: 7.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueGrey,width: 2.0),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5.0),
                                height: 7.0,
                                width: 7.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueGrey,width: 2.0),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 7.0,
                            width: 7.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey,width: 2.0),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                        ],
                      ),
                    ),
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
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
