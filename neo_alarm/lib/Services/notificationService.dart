
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(){
    initializeNotificationService();
  }


  void initializeNotificationService()async{
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


  void createAlarm(int id,List time,int phase,String body)async{
    Time t;
    print('phase:::'+phase.toString());
    if(phase==0){
      if(time[0]==12){
        t = Time(0,time[1],0);
      }else{
        t = Time(time[0],time[1],0);
      }
    }else{
      if(time[0]==12){
        t = Time(12,time[1],0);
      }else{
        t = Time(time[0]+12,time[1],0);
      }
    }
//    t=Time(0,19,0);
    print(t.hour);
    print(t.minute);
//    MethodChannel platform_ = MethodChannel('crossingthestreams.io/resourceResolver');
//    String alarmUri = await platform_.invokeMethod('getAlarmUri');
//    final x = UriAndroidNotificationSound(alarmUri);

    var android = new AndroidNotificationDetails(id.toString(),
        "channelName",
        "channelDescription",
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test',
//        sound: x,
//      playSound: true,
        styleInformation: DefaultStyleInformation(true, true));
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        'Neo',
        body+' Wake Up',
        t,
        platform);
//    await flutterLocalNotificationsPlugin.periodicallyShow(id, "title", "body", RepeatInterval.EveryMinute, platform);
  }

  Future<void> deleteNotification(int id)async{
    flutterLocalNotificationsPlugin.cancel(id);
  }

}
