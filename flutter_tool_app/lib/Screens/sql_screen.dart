import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SqlScreen extends StatefulWidget {
  @override
  _SqlScreenState createState() => _SqlScreenState();
}

class _SqlScreenState extends State<SqlScreen> {
  String dbPath;
  Database database;
  int id=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDB();

  }

  void initializeDB()async{
    var path = await getDatabasesPath();
    dbPath = join(path,'demo.db');

    database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE test (id INTEGER PRIMARY KEY, name TEXT)');
        });
  }

  void deleteDatabase()async{
//    await deleteDatabase(dbPath);
  }

  void insertData()async{
    var count = await database.insert('test', {'id':id});
    id+=1;
    print('Inserted $count');
  }

  void deleteData()async{
  }

  void readData()async{
    var data = await database.rawQuery('select * from test');
    print(data);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
              FlatButton(
                child: Text('Insert'),
                onPressed: (){
                  insertData();
                },
              ),
              FlatButton(
                child: Text('Read'),
                onPressed: (){
                  readData();
                },
              ),
              FlatButton(
                child: Text('Delete'),
                onPressed: (){
                  deleteData();
                },
              )
          ],
        ),
      ),
    );
  }
}
