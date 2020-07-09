

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AlarmList extends ChangeNotifier{
  List alarmList = [];

  void readData()async{

    String dbPath = "";
    var path = await getDatabasesPath();
    dbPath = join(path, 'dem.db');
    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {

          await db.execute('CREATE TABLE alarms (id INTEGER,title TEXT,hour INTEGER, minute INTEGER, part TEXT, active TEXT)');

        });
    alarmList = await  database.rawQuery('select * from alarms');
    print(alarmList);
    notifyListeners();

  }

  deleteAlarm(){

  }
}
