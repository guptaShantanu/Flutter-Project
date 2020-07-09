import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializer();
  }

  void initializer()async{
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var ios = new IOSInitializationSettings(onDidReceiveLocalNotification:onDidReceiveLocalNotification );
    var initSetting = new InitializationSettings(android, ios);
    await flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification:onNotificationSelect);
  }

  Future onNotificationSelect(String payload){
    debugPrint("PAYLOAD :: "+payload);
    showDialog(context: context,builder: (_)=>new AlertDialog(
      title: Text('Payload'),
      content: Text(payload),
    ));
  }

  Future onDidReceiveLocalNotification(int id ,String title,String body,String payload)async{
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: (){
            print("fdsa");
          },
          child: Text("Okay"),
        )
      ],
    );
  }


  void showNotification()async{
    var android = new AndroidNotificationDetails("channelId",
        "channelName",
        "channelDescription",
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test'
    );
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(0, "title", "", platform,payload: "Payload");
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.EveryMinute, platform);
  }

  Future<void> deleteNotification()async{
//    const channelId = 'channelId';
//    await flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        AndroidFlutterLocalNotificationsPlugin>()
//        ?.deleteNotificationChannel(channelId);
    flutterLocalNotificationsPlugin.cancel(0);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Generate Notification'),
                onPressed: (){
                      showNotification();
                },
              ),
              RaisedButton(
                child: Text('Repeated Notification'),
                onPressed: (){
                    deleteNotification();
                },
              ),
              RaisedButton(
                child: Text('Daily Notification'),
                onPressed: (){

                },
              ),
              RaisedButton(
                child: Text(''),
                onPressed: (){

                },
              ),
              RaisedButton(
                child: Text(''),
                onPressed: (){

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

