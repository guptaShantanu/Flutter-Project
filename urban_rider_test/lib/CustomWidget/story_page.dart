import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/Screens/profile_screen.dart';
import 'package:urbanridertest/Services/database_service.dart';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  var db = Firestore.instance;
  List<Widget> storyList = [];
  Map<String,String> urlList;
  var myUid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
//    getAllimageUrl();
  }
  
  void getAllData()async{
    var user = await FirebaseAuth.instance.currentUser();
    myUid = user.uid;
    
  }

//  void getAllimageUrl()async{
//    var db = Firestore.instance;
//    await db.collection(path)
//  }

  void giveLike(story_id){
    DatabaseService databaseService = DatabaseService();
    databaseService.giveLike(story_id);
  }


  Widget getStoryCard(context,line,likes,story_uid,uid) {
    return Container(
      height: 240.0,
      width: double.infinity,
      padding: EdgeInsets.only(
          top: 40.0, left: 10.0, right: 10.0, bottom: 20.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(line,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey,
                fontWeight: FontWeight.w800,
                fontSize: 20.0),),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return uid==myUid?ProfileScreen(mine: true):ProfileScreen(mine: false,uid: uid,);
                  }));
                },
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1558975355-c31d06c2f254?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    GestureDetector(onTap: (){
                      giveLike(story_uid);
//                      setState(() {
//
//                      });
                    },child: Icon(Icons.star, color: KMainThemeColors,)),
                    SizedBox(width: 5.0,),
                    Text(likes.toString()),
                    SizedBox(width: 5.0,),
                    Icon(Icons.share, color: KMainThemeColors,),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

    @override
    Widget build(BuildContext context) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: db.collection('story').snapshots(),
              builder: (conetext,snapshot){
                if(snapshot.hasData){
                  storyList=[];
                  var data = snapshot.data;
                  print(data.documents);
                  for(var story in data.documents){
                      storyList.add(getStoryCard(context, story['story'],story['likes'],story['story_id'],story['uid']));
                  }
                  print('updating');
//                  setState(() {
//                    storyList = storyList;
//                  });
                  return Container(
                    height: 250.0,
                    width: double.infinity,
                    child: SwipeStack(
                      stackFrom: StackFrom.Top,
                      translationInterval: 10,
                      scaleInterval: 0.03,
                      visibleCount: 5,
                      children: storyList.map((e) => SwiperItem(
                          builder: (pos,dub){
                            return e;
                          }
                      )).toList(),
                    ),
                  );
                }else{
                  return Container();
                }
              },
            ),

          ],
        ),
      );
    }
}

