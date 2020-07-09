import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:picker/picker.dart';
import 'package:http/http.dart' as http;

class DatabaseService{

  // updating user data
  Future<bool> updateProfile(name,handle_name,ride_name,rider_name,fav_qoute)async{
    var db = Firestore.instance;
    var user = await FirebaseAuth.instance.currentUser();
    var uid = user.uid;
    db.collection('user_info').document(uid).setData({
      "name":name,
      "ride_name":ride_name,
      "rider_name":rider_name,
      "fav_quote":fav_qoute,
      "handle_name":handle_name
    },merge: true).then((value){
      return true;
    }).catchError((error){
      return false;
    });
  }

  // getting user data
  Future<Map> getUserData()async{
    var db = Firestore.instance;
    var user = await FirebaseAuth.instance.currentUser();
    var uid = user.uid;
    var res = await db.collection('user_info').document(uid).get();
    return res.data;
  }
  
  // getting user data by uid
  Future<Map> getUserDataByUid(uid)async{
    var db = Firestore.instance;
    var res = await db.collection('user_info').document(uid).get();
    return res.data;
  }

  //saving image
  Future<String> saveImage()async{
    var resUrl;
    var db = Firestore.instance;
    var user = await FirebaseAuth.instance.currentUser();
    var uid = user.uid;
    var image = await Picker.pickImage(source: ImageSource.camera,  maxHeight: 480, maxWidth: 640, imageQuality: 75);
    var storageRef = FirebaseStorage.instance;
    await storageRef.ref().child(uid).putFile(image).onComplete.then((value) async{
      var  url = await storageRef.ref().child(uid).getDownloadURL();
      db.collection('user_info').document(uid).setData({
        "image_URL":url,
      },merge: true);
      resUrl =  url;
    });
    print(":::::::::");
    print(resUrl);
    print(":::::::::");
    return resUrl;

  }


  //post story
  Future<bool> saveStory(String story)async{
    bool result;
    var user = await FirebaseAuth.instance.currentUser();
    var uid = user.uid;
    var db = Firestore.instance;
    var key = UniqueKey().toString();
    await db.collection('story').document(key).setData({
      'uid':uid,
      'story_id':key,
      'likes':0,
      'story':story
    }).then((value)async{
      await db.collection('story_list').document(uid).collection('_').document(key).setData({
        'story_id':key,
      });
    }).catchError((error)=>result = false);
  }

  //give like
  Future<bool> giveLike(story_id)async{
      var db = Firestore.instance;
      var data = await db.collection('story').document(story_id).get();
      var likes = data.data['likes'];
      await db.collection('story').document(story_id).updateData({
        'likes':likes+1
      });
  }

  // get story list
  Future<List> getStoryList(String userID)async{
    var db = Firestore.instance;
    var data = await db.collection('story').getDocuments();
    var storyList = data.documents;
    List resultList = [];
    for(var story in storyList){
      if(story['uid'] == userID){
        resultList.add([story['story'],story['likes']]);
      }
    }
    print(resultList);
    return resultList;
  }

  // get video list
  Future<List> getVideoList(String userID)async{
    var db = Firestore.instance;
    var data = await db.collection('video').getDocuments();
    var storyList = data.documents;
    List<String> resultList = [];
    for(var story in storyList){
      if(story['uid'] == userID){
        resultList.add(story['id']);
      }
    }
    print(resultList);
    return resultList;
  }

  // save video
  Future<bool> saveVideo(String name,String id)async{
    bool result;
    var user = await FirebaseAuth.instance.currentUser();
    var uid = user.uid;
    var db = Firestore.instance;
    var key = UniqueKey().toString();
    await db.collection('video').document(key).setData({
      'uid':uid,
      'video_id':key,
      'name':name,
      'id':id
    }).then((value)async{
      await db.collection('video_list').document(uid).collection('_').document(key).setData({
        'video_id':key,
      });
    }).catchError((error)=>result = false);
  }


  //TODO get video list

  // get followers
  Future<int> getFollowers(String uid)async{
    var db = Firestore.instance;
    var user_data = await db.collection('followers').document(uid).get();
    int followers = user_data.data['no'];
    return followers;
  }

  // get following
  Future<int> getFollowing(String uid)async{
    var db = Firestore.instance;
    var user_data = await db.collection('following').document(uid).get();
    int following = user_data.data['no'];
    return following;
  }

  //follow person
  void followPerson(String userID)async {
    var user = await FirebaseAuth.instance.currentUser();
    var myUid = user.uid;
    var db = Firestore.instance;
    await db.collection('followers').document(userID).collection('f1').document(
        myUid).setData({
      'uid': myUid
    });
    var count1 = await getFollowers(userID);
    await db.collection('followers').document(userID).updateData(
        {'no': count1 + 1});

    await db.collection('following').document(myUid).collection('f2').document(
        userID).setData({
      'uid': userID
    });
    var count2 = await getFollowing(myUid);
    await db.collection('following').document(myUid).updateData(
        {'no': count2 + 1});
  }
    //unfollow person
    void unfollowPerson(String userID)async {
      var user = await FirebaseAuth.instance.currentUser();
      var myUid = user.uid;
      var db = Firestore.instance;
      await db.collection('followers').document(userID).collection('f1').document(
          myUid).delete();
      var count1 = await getFollowers(userID);
      await db.collection('followers').document(userID).updateData(
          {'no': count1 - 1});

      await db.collection('following').document(myUid).collection('f2').document(
          userID).delete();

    var count2 = await getFollowing(myUid);
    await db.collection('following').document(myUid).updateData(
        {'no': count2 - 1});
  }
  
  //check following
  Future<bool> checkFollowing(String userID)async{
    var user = await FirebaseAuth.instance.currentUser();
    var myUid = user.uid;
    var db = Firestore.instance;
    var data = await db.collection('following').document(myUid).collection('f2').document(userID).get();
    if (data.data!=null){
      return true;
    }else{
      return false;
    }
  }
}
