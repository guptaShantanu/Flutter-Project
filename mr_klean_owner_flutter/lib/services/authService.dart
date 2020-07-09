import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrkleanownerflutter/screens/login_screen.dart';

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

  static Future<bool> createUser (credential,name,email,phoneNo,address,flatNo,landmark,pincode) async {
    bool complete;
     AuthResult result = await FirebaseAuth.instance.signInWithCredential(credential);
     print("Auth Result");
     print("Auth user "+(result.user==null).toString());
     return false;

  }

  static void signOut(context){
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LoginScreen();
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