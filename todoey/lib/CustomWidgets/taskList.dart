import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/CustomWidgets/taskTile.dart';
import 'package:todoey/Services/notification_service.dart';
import 'package:todoey/list.dart';


class TaskList extends StatefulWidget {
  final Database database;
  final NotificaionService notificaionService;
  TaskList({this.database,this.notificaionService});
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {


  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: Provider.of<TasksList>(context).taskList.length,
        itemBuilder: (BuildContext context,int i){
      return TaskTile(index: i,database: widget.database,notificaionService:widget.notificaionService);
    });

  }
}
