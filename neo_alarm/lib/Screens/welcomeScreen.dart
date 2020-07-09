import 'package:flutter/material.dart';
import 'package:neoalarm/Constants/constant.dart';
import 'package:neoalarm/CustomWidgets/welcomeScreenCard.dart';
import 'package:neoalarm/Modal/alarmList.dart';
import 'package:neoalarm/Screens/mainScreen.dart';
import 'package:neoalarm/Services/databaseService.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 20),(){
        Provider.of<AlarmList>(context,listen: false).readData();
    });
    Future.delayed(Duration(milliseconds: 2000),()=>{

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return MainScreen();
      }))
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 238, 238, 1),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(30.0),
        child: Stack(
          children: <Widget>[
            WelcomeScreenCard(leftMargin: 20.0,topMargin: 20.0,image: 'images/clock1.png',),
            WelcomeScreenCard(leftMargin: 70.0,topMargin: 50.0,image: 'images/calender.png',),
            WelcomeScreenCard(leftMargin: 200.0,topMargin: 150.0,image: 'images/clock2.png',),
            WelcomeScreenCard(leftMargin: 10.0,topMargin: 400.0,image: 'images/alarm.png',),
            WelcomeScreenCard(leftMargin: 200.0,topMargin: 450.0,image: 'images/hourglass.png',),
            WelcomeScreenCard(leftMargin: 170.0,topMargin: 500.0,image: 'images/calender2.png',),
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Text('Alarm',style: TextStyle(fontFamily: 'Montserrat',fontSize: 40.0,shadows: [
                Shadow(blurRadius: 13.0,color: Colors.blueGrey,offset: Offset(4,4)),
              ]),),
            )
          ],
        ),
      ),
    );
  }
}


