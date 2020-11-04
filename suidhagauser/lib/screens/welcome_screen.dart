import 'package:flutter/material.dart';
import 'package:user/screens/home_screen.dart';
import 'dart:async';

import 'package:user/utils/network_service.dart';


class WelcomeScreen extends StatefulWidget {
  static String route = "/";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  NetworkService networkService = new NetworkService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUrl();
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, HomeScreen.route);
    });
  }

  void loadUrl() async {
    networkService.initiateUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Container(
          width: 250,
          height: 250,
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.5),
            radius: 50,
            child: Container(
              child: Image.asset('images/logo.png'),
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/welcome.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
