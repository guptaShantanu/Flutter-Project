import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoolapp/Screens/camera_screen.dart';
import 'package:fluttertoolapp/Screens/notification_screen.dart';
import 'package:fluttertoolapp/Screens/sql_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCameraProcess();
  }


  void startCameraProcess()async{
    WidgetsFlutterBinding.ensureInitialized();
    list = await availableCameras();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My TOOLS'),),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return CameraScreen(camera: list.first,);
                      }));
                    },
                    child: Container(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(5.0),
                      width: double.infinity,
                      height: 70.0,
                      alignment: Alignment.center,
                      child: Text('Back camera'),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return CameraScreen(camera: list.last,);
                      }));
                    },
                    child: Container(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(5.0),
                      width: double.infinity,
                      height: 70.0,
                      alignment: Alignment.center,
                      child: Text('Front camera'),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return SqlScreen();
                }));
              },
              child: Container(
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.all(5.0),
                width: double.infinity,
                height: 70.0,
                alignment: Alignment.center,
                child: Text('SQL'),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return NotificationScreen();
                }));
              },
              child: Container(
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.all(5.0),
                width: double.infinity,
                height: 70.0,
                alignment: Alignment.center,
                child: Text('Notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
