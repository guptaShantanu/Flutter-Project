import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neoalarm/Constants/constant.dart';

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  int minutes = 0, second = 0, milisecond = 0;
  List<String> lapList = [];
  Timer t;
  bool start = false;
  String butTitle = "Stop";
  bool stop = false;

  startStopWatch() {
    setState(() {
      milisecond += 1;
      if (milisecond == 100) {
        second += 1;
        milisecond = 0;
      }
      if (second == 60) {
        minutes += 1;
        second = 0;
      }
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(t!=null){
      t.cancel();
    }
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
                  child: Text('My Stopwatch', style: kPageTitleTextStyle),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 1.0,
                color: Colors.blueGrey,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        minutes.toString(),
                        style: kTitlePageTextStyle,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        ':',
                        style: kTitlePageTextStyle,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        second.toString(),
                        style: kTitlePageTextStyle,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        ':',
                        style: kTitlePageTextStyle,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        milisecond.toString(),
                        style: kTitlePageTextStyle,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: 1.0,
                color: Colors.blueGrey,
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: lapList.length,
                  itemBuilder: (context, index) {
                    return Text(
                        (index+1).toString()+' ::: '+lapList[index],
                      style: kPageTitleTextStyle,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          child: Text('Lap',style: TextStyle(color: Colors.white),),
                          decoration: kBottomIconGrayDecoration,
                          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                        ),
                        onTap: () {
                          setState(() {
                            lapList.add(minutes.toString() +
                                ' : ' +
                                second.toString() +
                                ' : ' +
                                milisecond.toString());
                          });
                        },
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                                child: Text('Start'),
                              decoration: kStopWatchControllerButton,
                              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),

                            ),
                            onTap: () {
                              if(!start || stop){
                                t = Timer.periodic(Duration(milliseconds: 10),
                                        (timer) {
                                      startStopWatch();
                                    });
                                start=true;
                                stop = false;
                              }
                            },
                          ),

                          GestureDetector(
                            child: Container(
                              child: Text(butTitle),
                              decoration: kStopWatchControllerButton,
                              padding: EdgeInsets.all(10.0),
                            ),
                            onTap: () {
                              if(start){
                                t.cancel();
                                stop = true;
                              }
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              child: Text('Reset'),
                              decoration: kStopWatchControllerButton,
                              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                            ),
                            onTap: () {
                              t.cancel();
                              setState(() {
                                minutes=0;
                                second=0;
                                milisecond=0;
                                lapList=[];
                                start=false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
