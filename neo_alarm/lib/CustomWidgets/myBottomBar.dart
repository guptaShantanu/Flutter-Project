import 'package:flutter/material.dart';
import 'package:neoalarm/Constants/constant.dart';


class MyBottomBar extends StatefulWidget {
  final onTap;

  MyBottomBar({this.onTap});

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int currentIndex = 0;
  double width1 = 60.0, width2 = 40.0, width3 = 40.0;
  Decoration deco1 = kBottomIconGrayDecoration, deco2 = kBottomIconWhiteDecoration, deco3 = kBottomIconWhiteDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: double.infinity,
      decoration: kNeoBoxDecoration,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40.0,
            decoration: currentIndex==0?kBottomIconGrayDecoration:kBottomIconWhiteDecoration,
            width: currentIndex == 0?60.0:40.0,
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.alarm),
              onPressed: () {
                widget.onTap(0);
                currentIndex = 0;
              },
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40.0,
            decoration: currentIndex==1?kBottomIconGrayDecoration:kBottomIconWhiteDecoration,
            width: currentIndex==1?60.0:40.0,
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.watch_later),
              onPressed: () {
                widget.onTap(1);
                currentIndex = 1;
              },
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40.0,
            decoration: currentIndex==2?kBottomIconGrayDecoration:kBottomIconWhiteDecoration,
            width: currentIndex==2?60.0:40.0,
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                widget.onTap(2);
                currentIndex = 2;
              },
            ),
          ),
        ],
      ),
    );
  }
}
