import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

  static Future<bool> signIn(credential,context)async{
    await FirebaseAuth.instance.signInWithCredential(credential);
    var user = await FirebaseAuth.instance.currentUser();
    if(user==null){
      print('Auhtentication Failed');
      return false;
    }else{
      return true;
    }
  }

//  db.collection('user_data').document(user.uid).setData({'username':name,"uid":user.uid,"emailId":email,"phoneNo":phoneNo,"address":address,"flatNo":flatNo,"landmark":landmark,"pincode":pincode});
//  db.collection('registered_users').document(phoneNo).setData({'isRegister':true});

  static Future<List> createUser (name,phoneNo,password,handlename) async {
    var db = Firestore.instance;
    var user = await FirebaseAuth.instance.currentUser();
    var uid = await user.uid;
    var handleCheck = await db.collection('handle_names').document(handlename).get();
    if(handleCheck.data==null){
      db.collection('users').document(uid).setData({
        "uid":uid,
        "name":name,
        "phone":phoneNo,
        "password":password,
        "handlename":handlename
      });
      db.collection('handle_names').document(handlename).setData({
        "handlename":handlename
      });
      db.collection("story_list").document(uid).setData({
        "uid":uid,
        "story_list":[],
        "recent_story":null
      });
      db.collection("user_info").document(uid).setData({
        "uid":uid,
        "name":name,
        "ride_name":"Ride name",
        "rider_name":"Rider name",
        "fav_quote":"Fav quote",
        "image_URL":null,
        "handle_name":handlename
      });

      db.collection("followers").document(uid).setData({
        "uid":uid,
        "no":0,
        "list":null
      });

      db.collection("following").document(uid).setData({
        "uid":uid,
        "no":0,
        "list":null
      });

      db.collection("video_list").document(uid).setData({
        "uid":uid,
        "list":[],
      });

      return [true,"User created"];
    }else{
      print(handleCheck);
      return [false,"invalid handle name"];
    }
  }

  static void signOut(context){
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return;
    }));
  }

  static Future<bool> checkAuth(context)async{
    var user =await FirebaseAuth.instance.currentUser();
    if (user!=null){
      return true;
    }else{
      return false;
    }
  }


  static Future<bool> checkUserExistance(phoneNo) async{
    var db = Firestore.instance;
    var snapshot = await db.collection('registered_user').document('$phoneNo').get();
    if(snapshot.data == null){
      return false;
    }else{
      return true;
    }
  }


}