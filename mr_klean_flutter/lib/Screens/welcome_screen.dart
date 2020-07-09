import 'package:flutter/material.dart';
import 'package:mrkleanflutter/Screens/laundry_list_screen.dart';
import 'package:mrkleanflutter/Screens/login_screen.dart';
import 'package:mrkleanflutter/Screens/registration_screen.dart';
import 'package:mrkleanflutter/Services/authService.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _iconShow = true;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    Future.delayed(Duration(microseconds: 500),(){
      setState(() {
        _iconShow = false;
      });
      print("IN Future");
    });
    Future.delayed(Duration(seconds: 4),(){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return isLogin?LaundryListScreen():LoginScreen();
      }));
    });
  }
  void getUser()async{
    isLogin = await AuthService.checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Container(
          alignment: Alignment.center,
          child: AnimatedOpacity(
              opacity: _iconShow?0.0:1.0,
              duration: Duration(seconds: 3),
              child: Hero(
                tag: 'splash_icon',
                child: Icon(
                  Icons.ac_unit,
                  size: 100.0,
                  color: Colors.white,
                ),
              ),
          ),
        ),
    );
  }
}
