import 'package:flutter/material.dart';
import 'package:neoalarm/Constants/constant.dart';
import 'package:neoalarm/Modal/alarmList.dart';
import 'package:neoalarm/Services/databaseService.dart';
import 'package:provider/provider.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  double h = 100.0;
  bool b = false;
  DatabaseService databaseService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }






  @override
  Widget build(BuildContext context) {
//    Provider.of<AlarmList>(context).readData();
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
                child: Text('My Alarm', style: kPageTitleTextStyle),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                  itemCount: Provider.of<AlarmList>(context,listen: true).alarmList.length,
                  itemBuilder: (context, index) {
                    List temp = Provider.of<AlarmList>(context,listen: true).alarmList;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 1.0),
                      ),
                      padding: EdgeInsets.all(3.0),
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                temp[index]['title'],
                                style: kAlarmTitleTextStyle,
                                textAlign: TextAlign.left,
                              ),
                              Switch(
                                activeTrackColor: Colors.green.shade700,
//                              inactiveThumbColor: Colors.blueGrey,
                                inactiveTrackColor: Colors.red,
                                activeColor: Colors.white,
                                value: temp[index]['active']=='true'?true:false,
                                onChanged: (val) {
                                  DatabaseService data = DatabaseService();
                                  temp[index]['active']=='true'?data.deactivateAlarm(temp[index]['id']):data.activateAlarm(temp[index]['id']);
                                  Provider.of<AlarmList>(context,listen: false).readData();
                                },
                              ),
                            ],
                          ),
                          Text('${temp[index]['hour']}:${temp[index]['minute']} ${temp[index]['part']=='0'?'AM':'PM'}',
                              style: kTitlePageTextStyle,
                              textAlign: TextAlign.left),
                          Container(
                            height: 1.0,
                            width: double.infinity,
                            color: Colors.blueGrey,
                            margin: EdgeInsets.all(5.0),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                DatabaseService dbs  = DatabaseService();
                                dbs.deleteAlarm(temp[index]['id']);
                                Provider.of<AlarmList>(context,listen: false).readData();
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
