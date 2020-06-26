import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/CustomWidgets/taskList.dart';
import 'package:todoey/Services/notification_service.dart';
import 'package:todoey/list.dart';
import 'package:todoey/Modal/tasks.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String myTask = "";
  Database database;
  String dbPath;
  TimeOfDay myTime;
  int myHour,myMinute;
  TimeOfDay currentTime = TimeOfDay.now();
  NotificaionService notificaionService;

  List<Widget> getTimeWidget(int n) {
    List<Widget> timeLlist = [];
    for (int i = 0; i <= n; i++) {
      timeLlist.add(Container(
          height:70.0,
          alignment: Alignment.center,
          child: Text(
            i.toString(),
            style: TextStyle(fontSize: 25.0),
          )));
    }
    return timeLlist;
  }

  Future showTimePicker_(BuildContext context)async{
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if(t!=null){
      myTime = t;
      myHour=myTime.hour;
      myMinute = myTime.minute;
      print(myTime);
    }
  }

  Widget buildBottomSheet(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'New Task',
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        myTask = value;
                      },
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      decoration:
                          InputDecoration(hintText: "Enter the new task"),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0,),
                    Text('Select time'),
                    SizedBox(height: 10.0,),
                    GestureDetector(
                      child: Text('Select time'),
                      onTap: (){
                        showTimePicker_(context);
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
//                setState(() {
                  if(myTime!=null){
                    Provider.of<TasksList>(context, listen: false)
                        .addTask(Task(task: myTask), database,(DateTime.now().millisecondsSinceEpoch/12345).toInt(),notificaionService,[myHour,myMinute]);
                    myTime = null;
                    Navigator.pop(context);
                  }
//                });
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: Text(
                  'Add task',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.symmetric(horizontal: 70.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.lightBlueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificaionService = NotificaionService();
    notificaionService.initializer();
    initializeDB();
  }

  void initializeDB() async {
    var path = await getDatabasesPath();
    dbPath = join(path, 'peta.db');

    database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
//      await db.execute('drop table tasks');
      await db.execute('CREATE TABLE mtasks (id INTEGER,task TEXT,isDone TEXT)');
    });
    print(' creation done');
  }

  void deleteDatabase() async {
//    await deleteDatabase(dbPath);
  }

  void insertData() async {
    var count =
        await database.insert('mtasks', {'id':11,'task': '0', 'isDone': 'false'});
//    await database.rawQuery('delete from tasks where 1=1');
    print('Inserted $count');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 14.0,
          splashColor: Colors.white,
          focusElevation: 5.0,
          focusColor: Colors.white,
          backgroundColor: Colors.blueGrey.shade700,
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
          insertData();
            showModalBottomSheet(
              context: context,
              builder: buildBottomSheet,
              elevation: 100.0,
            );

          }),
      backgroundColor: Colors.blueGrey.shade700,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 50.0, right: 30.0, left: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(239, 238, 238, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(216, 213, 208, 1),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 5.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-2.0, -2.0),
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<TasksList>(context, listen: false)
                          .initializeList(database);
                    },
                    child: Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Todo',
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  Provider.of<TasksList>(context).taskList.length.toString() +
                      " Tasks",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 40.0, left: 40.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.blueGrey, blurRadius: 10.0)
                ]),
            child: Provider.of<TasksList>(context).taskList.length == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      Icon(
                        Icons.search,
                        size: 100.0,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Sorry! No task available',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black26, fontSize: 20.0),
                      )
                    ],
                  )
                : TaskList(
                    database: database,
                    notificaionService:notificaionService
                  ),
          )),
        ],
      ),
    );
  }
}
