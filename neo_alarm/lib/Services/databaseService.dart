

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neoalarm/Modal/alarmList.dart';
import 'package:neoalarm/Services/notificationService.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  String dbPath;
  Database database;

  DatabaseService(){
    initializeDB();
  }


  void initializeDB() async {
    var path = await getDatabasesPath();
    dbPath = join(path, 'dem.db');

    this.database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
//      await db.execute('drop table tasks');
          await db.execute('CREATE TABLE alarms (id INTEGER,title TEXT,hour INTEGER, minute INTEGER, part TEXT, active TEXT)');
        });
    print(' creation done');
  }





  void addAlarm(int hour,int minute,int part,String title,BuildContext context)async{
    var path = await getDatabasesPath();
    dbPath = join(path, 'dem.db');
    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
//      await db.execute('drop table tasks');
//          await db.execute('CREATE TABLE alarms (id INTEGER,title TEXT,hour INTEGER, minute INTEGER, part TEXT, active TEXT)');
        });
    var data = await database.rawQuery('select * from alarms');
    print(data);
    int random = Random().nextInt(200000);
    await database.insert('alarms', {'id':random,'title':title,'hour':hour,'minute':minute,'part':part.toString(),'active':'true'});
//    database.execute('insert into alarms values($random,$title,$hour,$minute,$part,true)');
    print('Added to database');
    NotificationService notificationService = NotificationService();
    notificationService.createAlarm(random, [hour,minute], part, title);
    Provider.of<AlarmList>(context,listen: false).readData();

    database.close();

  }

  void deactivateAlarm(int id)async{

    var path = await getDatabasesPath();
    dbPath = join(path, 'dem.db');
    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
       });
    await database.rawQuery('update alarms set active = \'false\' where id = $id');
    NotificationService notificationService = NotificationService();
    notificationService.deleteNotification(id);
    
  }

  void activateAlarm(int id)async{

    var path = await getDatabasesPath();
    dbPath = join(path, 'dem.db');
    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
        });
    await database.rawQuery('update alarms set active = \'true\' where id = $id');
//    NotificationService notificationService = NotificationService();
//    notificationService.deleteNotification(id);

  }


  void deleteAlarm(int id)async{

    var path = await getDatabasesPath();
    dbPath = join(path, 'dem.db');
    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
        });
    await database.rawQuery('delete from alarms where id = $id');
    NotificationService notificationService = NotificationService();
    notificationService.deleteNotification(id);

  }




}
