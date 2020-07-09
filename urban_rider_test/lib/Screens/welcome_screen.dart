import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/Screens/AuthScreen.dart';
import 'package:urbanridertest/Screens/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double opacity = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity=1.0;
      });
    });
//    Future.delayed(Duration(seconds: 3), () {
//      Navigator.push(
//          context, MaterialPageRoute(builder: (context) => AuthScreen()));
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/rider.jpg'),
            ),
            gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 100.0),
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 1),
                    child: Text(
                'Urban Rider',
                style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontStyle: FontStyle.italic,
                      shadows: [Shadow(blurRadius: 2.0,color: KMainThemeColors,offset: Offset(2,3))],
                      fontWeight: FontWeight.w800),
              ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(seconds: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                      RaisedButton(
                        onPressed: (){},
                        elevation: 0,
                        padding: EdgeInsets.all(0),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(width: 2.0,color: KMainThemeColors,)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 15.0),
                          child: Text('Sign In',style: TextStyle(color: KMainThemeColors,fontSize: 20.0),),
                        ),
                      ),
                    RaisedButton(
                      onPressed: (){
                              Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthScreen()));
                      },
                      elevation: 0,
                      padding: EdgeInsets.all(0),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: KMainThemeColors,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(width: 2.0,color: KMainThemeColors,)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 15.0),
                        child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
