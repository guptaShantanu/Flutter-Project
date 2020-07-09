import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/Screens/edit_profile_scrren.dart';
import 'package:urbanridertest/Services/database_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final bool mine;
  final String uid;
  ProfileScreen({this.mine, this.uid});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentPageIndex = 0;
  Color activeColor = KMainThemeColors;
  Color disableColor = Colors.blueGrey;
  Widget currentPage = ProfilePage1();
  bool followingUser = false;
  List storyList = [];
  List<String> videoList = [];

  String name = '',
      ride_name = '',
      rider_name = '',
      fav_qoute = '',
      image_URL = '',
      handle_name = '',
      video_name='',
      video_url=''
  ;
  int followers = 0, following = 0;

  Widget buildAddDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Add video'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            onChanged: (val){
              video_name = val;
            },
            decoration: InputDecoration(labelText: 'Video name'),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            onChanged: (val){
              video_url = val;
            },
            decoration: InputDecoration(labelText: 'Youtube URL'),
          ),
        ],
      ),
      actions: <Widget>[
        new RaisedButton(
          onPressed: () {
            int temp = video_url.indexOf('/',10);
            String videoId = video_url.substring(temp+1);
            print(videoId);
            DatabaseService databaseService =  DatabaseService();
            databaseService.saveVideo(video_name,videoId).then((value){
              getAllData();
            });
            Navigator.of(context).pop();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          textColor: Theme.of(context).primaryColor,
          color: KMainThemeColors,
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  void getAllData() async {
    if (widget.mine) {
      var user = await FirebaseAuth.instance.currentUser();
      var uid = user.uid;
      DatabaseService databaseService = new DatabaseService();
      videoList = await databaseService.getVideoList(uid);
      storyList  = await databaseService.getStoryList(uid);
      following = await databaseService.getFollowing(uid);
      followers = await databaseService.getFollowers(uid);
      var userData = await databaseService.getUserData();
      setState(() {
        currentPage = currentPageIndex==0?ProfilePage1(videoList: videoList,):ProfilePage2(storyList: storyList,);
        name = userData["name"];
        ride_name = userData['ride_name'];
        rider_name = userData['rider_name'];
        fav_qoute = userData['fav_quote'];
        image_URL = userData['image_URL'];
        handle_name = userData["handle_name"];
      });
    } else {
      DatabaseService databaseService = new DatabaseService();
      storyList  = await databaseService.getStoryList(widget.uid);
      videoList = await databaseService.getVideoList(widget.uid);
      following = await databaseService.getFollowing(widget.uid);
      followers = await databaseService.getFollowers(widget.uid);
      followingUser = await databaseService.checkFollowing(widget.uid);
      var userData = await databaseService.getUserDataByUid(widget.uid);
      setState(() {
        currentPage = currentPageIndex==0?ProfilePage1(videoList: videoList,):ProfilePage2(storyList: storyList,);
        name = userData["name"];
        ride_name = userData['ride_name'];
        rider_name = userData['rider_name'];
        fav_qoute = userData['fav_quote'];
        image_URL = userData['image_URL'];
        handle_name = userData["handle_name"];
      });
    }
  }

  void followPerson(){
    DatabaseService databaseService = DatabaseService();
    databaseService.followPerson(widget.uid);
  }

  void unfollowPerson()async{
    DatabaseService databaseService = DatabaseService();
    databaseService.unfollowPerson(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KMainThemeColors,
        title: Text('Brand name'),
        centerTitle: true,
      ),
      floatingActionButton: currentPageIndex == 0 && widget.mine
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: KMainThemeColors,
                size: 30.0,
              ),
              elevation: 10.0,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: buildAddDialog,
                  barrierDismissible: false,
                );
              },
            )
          : null,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: image_URL == null || image_URL == ''
                            ? CircleAvatar(
                                radius: 50.0,
                                child: Icon(
                                  Icons.person,
                                  size: 70.0,
                                  color: KMainThemeColors,
                                ),
                                backgroundColor: Colors.blueGrey.shade50,
                              )
                            : Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                          offset: Offset(3, 3)),
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                          offset: Offset(-1, -1)),
                                    ],
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(image_URL))),
                              ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      followers.toString(),
                                      style: TextStyle(
                                          color: KMainThemeColors,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Followers',
                                      style: TextStyle(color: KMainThemeColors),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      following.toString(),
                                      style: TextStyle(
                                          color: KMainThemeColors,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Following',
                                      style: TextStyle(color: KMainThemeColors),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            widget.mine
                                ? RaisedButton(
                                    onPressed: ()async {
                                      var c = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfileScreen())).then((value){
                                                    getAllData();
                                      });
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.blueGrey, width: 1.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                  )
                                : RaisedButton(
                                    onPressed: () {
                                      if(followingUser){
                                        unfollowPerson();
                                      }else{
                                        followPerson();
                                      }
                                      setState(() {
                                        followingUser = !followingUser;
                                      });
                                      getAllData();
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.blueGrey, width: 1.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      followingUser?'Unfollow':'Follow',
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          handle_name,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              color: KMainThemeColors,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          fav_qoute,
                          style: TextStyle(
                              color: KMainThemeColors, fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          rider_name,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          ride_name,
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPageIndex = 0;
                        currentPage = ProfilePage1(videoList: videoList,);
                      });
                    },
                    icon: Icon(
                      Icons.video_library,
                      color: currentPageIndex == 0
                          ? KMainThemeColors
                          : disableColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPageIndex = 1;
                        currentPage = ProfilePage2(storyList: storyList,);
                      });
                    },
                    icon: Icon(
                      Icons.textsms,
                      color: currentPageIndex == 1
                          ? KMainThemeColors
                          : disableColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            width: double.infinity,height: 1.0,color: Colors.blueGrey,),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: currentPage,
                transitionBuilder: (child, animation) {
                  final fromRightAnimation =
                      Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                          .animate(animation);
                  final fromLeftAnimation =
                      Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                          .animate(animation);

                  if (child.key == ValueKey(1)) {
                    print("go");
                    return ClipRect(
                      child: SlideTransition(
                        position: fromLeftAnimation,
                        child: child,
                      ),
                    );
                  } else {
                    print("out");
                    return ClipRect(
                      child: SlideTransition(
                        position: fromRightAnimation,
                        child: child,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePage1 extends StatefulWidget {
  final key = ValueKey(1);
  final List<String> videoList;
  ProfilePage1({this.videoList});

  @override
  _ProfilePage1State createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {

  Widget getVideoCard(String id){
    PlayerState _playerState;

    YoutubeMetaData _videoMetaData;

    double _volume = 100;

    bool _muted = false;

    bool _isPlayerReady = false;

    YoutubePlayerController controller ;

    void listener() {
      if (_isPlayerReady && mounted && !controller.value.isFullScreen) {
        setState(() {
          _playerState = controller.value.playerState;
          _videoMetaData = controller.metadata;
        });
      }
    }

    _playerState = PlayerState.unknown;
    controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);

    return Container(
        width: double.infinity,
        height: 200.0,
        margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 3.0,
                color: Colors.blueGrey,
                offset: Offset(
                  3,
                  3,
                ))
          ],
        ),
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          liveUIColor: Colors.amber,
        )
    );
  }

  List<Widget> getVideoCardList(){
    if(widget.videoList==null || widget.videoList.length == 0){
      return [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text('Sorry no data :(',style: TextStyle(fontSize: 30.0,color: KMainThemeColors),),
        )
      ];
    }
    return widget.videoList.map((e){
      return getVideoCard(e);
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        children: getVideoCardList(),
      ),
    );
  }
}

class ProfilePage2 extends StatelessWidget {
  final key = ValueKey(2);
  final List storyList;
  ProfilePage2({this.storyList});

  List<Widget> getList(){
    if(storyList == null || storyList.length == 0){
      return [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0,horizontal:20.0),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text('Sorry no data :(',style: TextStyle(fontSize: 30.0,color: KMainThemeColors),),
        )
      ];
    }else{
      return storyList.map((e){
        return getStatusCard(e);
      }).toList();
    }
  }

  Widget getStatusCard(line) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              blurRadius: 3.0,
              color: Colors.blueGrey,
              offset: Offset(
                3,
                3,
              ))
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            line[0],
            style: TextStyle(
                color: KMainThemeColors,
                fontWeight: FontWeight.w800,
                fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.star,
                  color: KMainThemeColors,
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(line[1].toString()),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.share,
                  color: KMainThemeColors,
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
      child: ListView(
        children: getList(),
      ),
    );
  }
}
