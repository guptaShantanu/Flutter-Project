import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/CustomWidget/story_page.dart';
import 'package:urbanridertest/CustomWidget/write_page.dart';
import 'package:urbanridertest/Screens/AuthScreen.dart';
import 'package:urbanridertest/Screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int navIndex = 0;

  Widget getPage(int index) {
    if (index == 0) {
      return StoryPage();
    } else if (index == 1) {
      return WritePage();
    } else {
      return ProfileScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: GestureDetector(
                    onTap: (){
                      var auth = FirebaseAuth.instance;
                      auth.signOut();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AuthScreen()));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'LOGOUT',
                          style: TextStyle(color: Colors.black,fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ))),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: KMainThemeColors,
        title: Text('Brand name'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(
              Icons.home,
              color: KMainThemeColors,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: KMainThemeColors),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              activeIcon: Icon(
                Icons.edit,
                color: KMainThemeColors,
              ),
              title: Text(
                'Write',
                style: TextStyle(color: KMainThemeColors),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(
                Icons.person,
                color: KMainThemeColors,
              ),
              title: Text(
                'Profile',
                style: TextStyle(color: KMainThemeColors),
              )),
        ],
        onTap: (val) {
          if (val == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          mine: true,
                        )));
          } else {
            setState(() {
              navIndex = val;
            });
          }
        },
      ),
      body: getPage(navIndex),
    );
  }
}
