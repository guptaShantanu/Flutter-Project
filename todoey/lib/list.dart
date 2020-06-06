import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/Services/notification_service.dart';

import 'Modal/tasks.dart';
import 'package:provider/provider.dart';

class TasksList extends ChangeNotifier{
  List<Task> taskList = [];

  void initializeList(Database database)async{
    List<Map> data = await database.rawQuery('select * from mtasks');
    print(data);
    List<Task> tempList=[];
    for(int i=0;i<data.length;i++){
      tempList.add(Task(id:data[i]['id'],task: data[i]['task'],isDone:data[i]['isDone']=='true'?true:false ));
    }
    taskList=tempList;
    notifyListeners();
  }


  void addTask(task,Database db,int id,NotificaionService notificaionService,List time)async{
    await db.insert('mtasks', {'id':id,'task':task.task.toString(),'isDone':'false'});
    List<Map> data = await db.rawQuery('select * from mtasks');
    print(data);
    List<Task> tempList=[];
    for(int i=0;i<data.length;i++){
      tempList.add(Task(id:data[i]['id'],task: data[i]['task'],isDone:data[i]['isDone']=='true'?true:false ));
    }
    taskList=tempList;
    notificaionService.showNotification(id, time,task.task.toString());
//    taskList.add(task);
    notifyListeners();
  }

  void deleteTask(Database database,int id,NotificaionService notificaionService) async{
    var res=await database.rawQuery('delete from mtasks where id=$id');
    if(res!=null){
      List<Map> data = await database.rawQuery('select * from mtasks');
      print(data);
      List<Task> tempList=[];
      for(int i=0;i<data.length;i++){
        tempList.add(Task(id:data[i]['id'],task: data[i]['task'],isDone:data[i]['isDone']=='true'?true:false ));
      }
      taskList=tempList;
      notificaionService.deleteNotification(id);
      notifyListeners();
    }
  }

  void toggleTask(Database database,int id,bool isDone)async{
    var res = await database.rawQuery('update mtasks set isDone = \'${!isDone}\' where id=$id');
    if(res!=null){
      List<Map> data = await database.rawQuery('select * from mtasks');
      print(data);
      List<Task> tempList=[];
      for(int i=0;i<data.length;i++){
        tempList.add(Task(id:data[i]['id'],task: data[i]['task'],isDone:data[i]['isDone']=='true'?true:false ));
      }
      taskList=tempList;
      notifyListeners();
    }
  }
}