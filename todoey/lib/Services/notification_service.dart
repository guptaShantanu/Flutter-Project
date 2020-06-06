import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificaionService{
  NotificaionService(){

  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  void initializer()async{
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var ios = new IOSInitializationSettings(onDidReceiveLocalNotification:this.onDidReceiveLocalNotification );
    var initSetting = new InitializationSettings(android, ios);
    await flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification:this.onNotificationSelect);
  }

  Future onNotificationSelect(String payload){
    debugPrint("PAYLOAD :: "+payload);
//    showDialog(context: context,builder: (_)=>new AlertDialog(
//      title: Text('Payload'),
//      content: Text(payload),
//    ));
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


  void showNotification(int id,List time,String body)async{
    Time t = Time(time[0],time[1],1);
    var android = new AndroidNotificationDetails("channelId",
        "channelName",
        "channelDescription",
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test'
    );
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        'TODO',
        body+' time',
        t,
        platform);
//    await flutterLocalNotificationsPlugin.periodicallyShow(id, "title", "body", RepeatInterval.EveryMinute, platform);
  }

  Future<void> deleteNotification(int id)async{
//    const channelId = 'channelId';
//    await flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        AndroidFlutterLocalNotificationsPlugin>()
//        ?.deleteNotificationChannel(channelId);
    flutterLocalNotificationsPlugin.cancel(id);
  }
}