import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/Services/notification_service.dart';
import 'package:todoey/list.dart';

class TaskTile extends StatelessWidget {
  final int index;
  final Database database;
  final NotificaionService notificaionService;

  TaskTile({this.index,this.database,this.notificaionService});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksList>(builder: (context, task, child) {
      return ListTile(
        onLongPress: () {
          if (task.taskList[index].isDone) {
            Alert(
              context: context,
              type: AlertType.warning,
              title: "Todoey",
              desc: "Do you want to delete this task ?",
              buttons: [
                DialogButton(
                  color: Colors.red,
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    task.deleteTask(database,task.taskList[index].id,notificaionService);
                    Navigator.pop(context);
                  },
                  width: 120,
                )
              ],
            ).show();
          }
        },
          title: Text(
            Provider.of<TasksList>(context).taskList[index].task,
            style: TextStyle(
                fontWeight:
                    task.taskList[index].isDone
                        ? FontWeight.w700
                        : null,
                decoration:
                    task.taskList[index].isDone
                        ? TextDecoration.lineThrough
                        : null),
          ),
          trailing: Checkbox(
            value: Provider.of<TasksList>(context).taskList[index].isDone,
            onChanged: (newState) {
              task.toggleTask(database,task.taskList[index].id,task.taskList[index].isDone);
            },
            activeColor: Colors.lightBlueAccent,
          ));
    });
  }
}
