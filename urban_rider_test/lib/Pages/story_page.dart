import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/Screens/profile_screen.dart';
import 'package:urbanridertest/Services/database_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  var db = Firestore.instance;
  List<Widget> storyList = [];
  var myUid;

  @override
  void initState() {
    getAllData();
    super.initState();

//    getAllimageUrl();
  }
  
  void getAllData()async{
    var user = await FirebaseAuth.instance.currentUser();
    myUid = user.uid;
    var videoData = await db.collection('video').getDocuments();
    for(var v in videoData.documents){
        storyList.add(getStoryCard(context, v.data['name'], v.data['id']));
      print(v.data['name']);
    }
    setState(() {
      storyList = storyList;
    });

  }

  void giveLike(story_id){
    DatabaseService databaseService = DatabaseService();
    databaseService.giveLike(story_id);
  }


  Widget getVideoImageCard(String id){
    return Container(
        width: double.infinity,
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 3.0,
                color: Colors.blueGrey,
                offset: Offset(
                  3,
                  3,
                ))
          ],
          image: DecorationImage(
            image: NetworkImage('http://i1.ytimg.com/vi/$id/0.jpg'),
            fit: BoxFit.cover
          )
        ),
      alignment: Alignment.center,
      child:Icon(Icons.play_arrow,size: 90.0,color: KMainThemeColors,),
    );
  }


  Widget getStoryCard(context,name,id) {
    return Container(
      height: 300.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 2.0, offset: Offset(2, 2), color: Colors.blueGrey),
            BoxShadow(
                blurRadius: 2.0, offset: Offset(0, -2), color: Colors.blueGrey)
          ]),
      child: Column(
        children: <Widget>[
          getVideoImageCard(id),
          Container(
            height: 50.0,
            width: double.infinity,
            color: Colors.red,
          )
        ],
      )
    );
  }

    @override
    Widget build(BuildContext context) {
    print('setState');
      return Container(
        height: 300.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Container(
//              height: 300.0,
//              width: double.infinity,
//              child: SwipeStack(
//                stackFrom: StackFrom.Top,
//                translationInterval: 6,
//                scaleInterval: 0.03,
//                visibleCount: 3,
//                historyCount: 6,
//                animationDuration: Duration(milliseconds: 100),
//                children: storyList.map((e) => SwiperItem(
//                    builder: (pos,dub){
//                      return e;
//                    }
//                )).toList(),
//              ),
//            ),
            storyList.length==0?Icon(Icons.cloud_download,size: 80.0,color: KMainThemeColors,):Swiper(
              itemBuilder: (BuildContext context, int index) {
                return storyList[index];
              },
              itemCount: storyList.length,
              itemWidth: 300.0,
              itemHeight: 250.0,
              layout: SwiperLayout.STACK,
            ),
          ],
        ),
      );
    }
}

