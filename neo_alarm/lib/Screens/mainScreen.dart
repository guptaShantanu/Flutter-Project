import 'package:flutter/material.dart';
import 'package:neoalarm/CustomWidgets/buildBottomSheet.dart';
import 'package:neoalarm/CustomWidgets/myBottomBar.dart';
import 'package:neoalarm/Modal/alarmList.dart';
import 'package:neoalarm/Pages/alarmPage.dart';
import 'package:neoalarm/Pages/clockPage.dart';
import 'package:neoalarm/Pages/stopWatchPage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget getPage(int index) {
    if (index == 0) {
      return AlarmPage();
    } else if (index == 1) {
      return ClockPage();
    } else {
      return StopWatchPage();
    }
  }

  void setPage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:currentIndex==0? FloatingActionButton(backgroundColor: Colors.blueGrey,
      onPressed: (){
        showModalBottomSheet(
          context: context,
          builder: buildBottomSheet,
          elevation: 100.0,
        );
      },):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: MyBottomBar(
        onTap: setPage,
      ),
      body: getPage(currentIndex),
    );
  }
}

