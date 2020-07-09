import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:urbanridertest/Services/notification_service.dart';

Future onNotificationSelect(String payload){
  debugPrint("PAYLOAD :: "+payload);
//    showDialog(context: context,builder: (_)=>new AlertDialog(
//      title: Text('Payload'),
//      content: Text(payload),
//    ));
}

Future onDidReceiveLocalNotification(int id ,String title,String body,String payload)async{
  return null;
}


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("onBackgroundMessage: $message");
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var android = new AndroidInitializationSettings('app_icon');
  var ios = new IOSInitializationSettings(onDidReceiveLocalNotification:onDidReceiveLocalNotification );
  var initSetting = new InitializationSettings(android, ios);
  await flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification:onNotificationSelect);
  var androidS = new AndroidNotificationDetails("channelId",
      "channelName",
      "channelDescription",
      priority: Priority.Max,
      importance: Importance.Max,
      ticker: 'test'
  );
  var iosS = new IOSNotificationDetails();
  var platform = new NotificationDetails(androidS, iosS);
  await flutterLocalNotificationsPlugin.show(
      40404,
      'TODO',
      'Push'+' time',
      platform);
  return Future<void>.value();
}


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FirebaseMessaging _firebaseMessaging;

  void makeNotification(){
    NotificaionService notificaionService = NotificaionService();
    notificaionService.initializer();
    notificaionService.showNotification(46474);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onBackgroundMessage: myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        makeNotification();
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        makeNotification();
//        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        makeNotification();

//        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: RaisedButton(
            child: Text('send'),
          onPressed: ()async{
              print(await _firebaseMessaging.getToken());
              print(await _firebaseMessaging.getToken());
            String server_key = 'AAAA-pzt4VA:APA91bFp5TX7pdTxeCaReHYYPbvNz4fWK4VOKacNtldUgdL_3c5vbJf5wKGygUhj7NkW9dPrPUWP_DWZpUV3ocLYYlU-miSsHbBzBgeqKgowuNy0KqAAJUaeE_hih2fz46j3_n0oQ4zF';
            await _firebaseMessaging.requestNotificationPermissions(
              const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
            );

            await http.post(
              'https://fcm.googleapis.com/fcm/send',
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'key=$server_key',
              },
              body: jsonEncode(
                <String, dynamic>{
                  'notification': <String, dynamic>{
                    'body': 'this is a body',
                    'title': 'this is a title'
                  },
                  'priority': 'high',
                  'data': <String, dynamic>{
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                    'id': '1',
                    'status': 'done',
                    'messgae':'service came'
                  },
                  'to': await _firebaseMessaging.getToken(),
                },
              ),
            );

              final Completer<Map<String, dynamic>> completer =
              Completer<Map<String, dynamic>>();

              _firebaseMessaging.configure(
                onMessage: (Map<String, dynamic> message) async {
                  completer.complete(message);
                },
              );

              return completer.future;
          },
        ),
      ),
    );
  }

}
