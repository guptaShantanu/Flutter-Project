import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Sequence Animation
//Rubber
//Sprung
//Animated text kit


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  var vertical = 0;
  var left = 0;
  AnimationController controller, floatController;
  Animation animation, floatAnimation;
  bool menu = false, float = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 100));
    animation =
        new CurvedAnimation(parent: controller, curve: Curves.easeInOut);


    floatController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    floatAnimation =
        new CurvedAnimation(parent: floatController, curve: Curves.linear);
  }

  void showMenu() {
    if (float) {
      showOption();
    }

    if (!menu) {
      controller.forward();
      menu = true;
    } else {
      controller.reverse(from: 1.0);
      menu = false;
    }

    animation.addListener(() {
      setState(() {});
    });
  }

  void showOption() {
    if (!menu) {
      if (!float) {
        floatController.forward();
        float = true;
      } else {
        floatController.reverse(from: 1.0);
        float = false;
      }

      floatAnimation.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 20.0,
          backgroundColor: Colors.blue.shade800,
          leading: IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: animation,
              color: Colors.white,
            ),
            onPressed: () {
              showMenu();
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.blueGrey.shade800,
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.event,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: animation.value * 110,
                      top: animation.value * 30,
                      bottom: animation.value * 30),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              5.0,
                              5.0,
                            ))
                      ],
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(animation.value * 20),
                          bottomLeft: Radius.circular(animation.value * 20))),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(
                      left: animation.value * 150,
                      top: animation.value * 30,
                      bottom: animation.value * 30),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            spreadRadius: 5.0,
                            offset: Offset(
                              5.0,
                              5.0,
                            ))
                      ],
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(animation.value * 20),
                          bottomLeft: Radius.circular(animation.value * 20))),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              right: 10.0,
                              bottom: floatAnimation.value * 120 + 10.0),
                          height: 50.0 - animation.value * 10,
                          width: 50.0 - animation.value * 10,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(
                            Icons.keyboard_voice,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          showOption();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              right: 10.0,
                              bottom: floatAnimation.value * 60 + 10.0),
                          height: 50.0 - animation.value * 10,
                          width: 50.0 - animation.value * 10,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          showOption();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          height: 50.0 - animation.value * 10,
                          width: 50.0 - animation.value * 10,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey.shade800,
                                  blurRadius: 3.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ))
                            ],
                          ),
                          child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            color: Colors.white,
                            progress: floatAnimation,
                          ),
                        ),
                        onTap: () {
                          showOption();
                        },
                      ),
                    ],
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
