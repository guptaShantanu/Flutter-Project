import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neoalarm/Constants/constant.dart';
import 'package:neoalarm/Modal/alarmList.dart';
import 'package:neoalarm/Services/databaseService.dart';
import 'package:provider/provider.dart';

int hour=1,minute=0,phase=0;
String alarmTitle="";

void addAlarm(context){
  print("Phesaaa::::"+phase.toString());
  DatabaseService databaseService = DatabaseService();
  databaseService.addAlarm(hour, minute, phase,alarmTitle,context);

}


List<Widget> getTimeWidget(int m,int n) {
  List<Widget> timeLlist = [];
  for (int i = m; i <= n; i++) {
    timeLlist.add(Container(
        height: 40.0,
        alignment: Alignment.center,
        child: Text(
          i.toString(),
          style: TextStyle(fontSize: 25.0),
        )));
  }
  return timeLlist;
}

Widget buildBottomSheet(BuildContext context) {
  return Container(
    color: KBackgroundColor,
    padding: EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        Text(
          'Add alarm',
          style: kAlarmTitleTextStyle,
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.blueGrey,
          margin: EdgeInsets.all(5.0),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
          margin: EdgeInsets.all(5.0),
          child: TextField(
            onChanged: (value){
              alarmTitle=value;
            },
            decoration: InputDecoration(
                focusColor: Colors.blueGrey,
                hoverColor: Colors.blueGrey,
                hintText: 'Enter the title'),
          ),
        ),
        SizedBox(height: 10.0,),

        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'HOUR',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'MINUTE',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'AM/PM',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 100.0,
                child: CupertinoPicker(
                  itemExtent: 60,
                  children: getTimeWidget(1,12),
                  onSelectedItemChanged: (value) {
                    hour=value+1;
                  },
                ),
              ),
            ),
            Container(
              height: 90.0,
              width: 1.0,
              color: Colors.blueGrey,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 100.0,
                child: CupertinoPicker(
                  itemExtent: 60,
                  children: getTimeWidget(0,59),
                  onSelectedItemChanged: (value) {
                    minute = value;
                  },
                ),
              ),
            ),
            Container(
              height: 90.0,
              width: 1.0,
              color: Colors.blueGrey,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 100.0,
                child: CupertinoPicker(
                  itemExtent: 60,
                  children: <Widget>[
                    Container(
                        height: 40.0,
                        alignment: Alignment.center,
                        child: Text(
                          'AM',
                          style: TextStyle(fontSize: 25.0),
                        )),
                    Container(
                        height: 40.0,
                        alignment: Alignment.center,
                        child: Text(
                          'PM',
                          style: TextStyle(fontSize: 25.0),
                        ))
                  ],
                  onSelectedItemChanged: (value) {
                    print(value);
                    phase=value;
                  },
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: (){
            addAlarm(context);
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(30.0),
            padding: EdgeInsets.all(10.0),
            child: Text('Add alarm'),
            decoration: kNeoBoxDecoration,
          ),
        )
      ],
    ),
  );
}
