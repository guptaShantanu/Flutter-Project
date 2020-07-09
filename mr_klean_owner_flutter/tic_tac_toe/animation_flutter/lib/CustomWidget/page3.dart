
import 'package:flutter/material.dart';

import 'Page3Parts/part1.dart';
import 'Page3Parts/part2.dart';

class Page3 extends StatefulWidget {
  final Color color;
  Key key = ValueKey(3);

  Page3({this.color});
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  Widget currentWidget = Part1(
  );

  bool right = true;

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
                      onTap: () {
                        right = false;
                        setState(() {
                          currentWidget = Part1(
                          );
                        });
                      },
                      child: Container(
                        width: 10.0,
                        height: 20.0,
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.shade700,
                                  blurRadius: 2.0,
                                  offset: Offset(2, 3))
                            ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        right = true;
                        setState(() {
                          currentWidget = Part2(
                          );
                        });
                      },
                      child: Container(
                        width: 10.0,
                        height: 20.0,
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.shade700,
                                  blurRadius: 2.0,
                                  offset: Offset(2, 3))
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: currentWidget,
              transitionBuilder: (child, animation) {
                final fromRightAnimation =
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                        .animate(animation);
                final fromLeftAnimation =
                    Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                        .animate(animation);
                final toLeftAnimation =
                    Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
                        .animate(animation);
                final toRightAnimation =
                    Tween<Offset>(begin: Offset(0, 0), end: Offset(1, 0))
                        .animate(animation);
                print(child.key);

                if (right == null) {
                  return ClipRect(
                    child: SlideTransition(
                      position: fromLeftAnimation,
                      child: child,
                    ),
                  );
                }

                if (child.key == ValueKey(11)) {
                  print("go");
                  return ClipRect(
                    child: SlideTransition(
                      position: fromLeftAnimation,
                      child: child,
                    ),
                  );
                } else {
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
