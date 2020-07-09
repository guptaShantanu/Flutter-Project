import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrkleanflutter/Services/authService.dart';
import 'package:mrkleanflutter/Services/locationService.dart';

class LaundryListScreen extends StatefulWidget {
  @override
  _LaundryListScreenState createState() => _LaundryListScreenState();
}

class _LaundryListScreenState extends State<LaundryListScreen> {
  final db = Firestore.instance;
  final auth = FirebaseAuth.instance;
  String username="";
  List myLocation;
  LocationService locationService = new LocationService();
  var search="";




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData()async{
    var user = await auth.currentUser();
    var token = await user.getIdToken(refresh: true);
    var snapshot = await db.collection("user_data").document(user.uid).get();
    setState(() {
      username = snapshot.data['username'];
    });
    myLocation = await locationService.getLocation();
    print(myLocation.length);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
        decoration: BoxDecoration(color: Colors.lightBlueAccent,),
        child: Column(
          children: <Widget>[
            Container(
              height: 200.0,
            decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(blurRadius: 4.0,spreadRadius: 2.0,color: Colors.black45)]),),
            GestureDetector(
              onTap: (){
                AuthService.signOut(context);
              },
              child: Container(
                height: 50.0,
                margin: EdgeInsets.only(top: 10.0,bottom: 5.0,left: 20.0,right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            ),


          ],
        ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Mr Klean',style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:10.0),
            child: Column(
              children: <Widget>[
                CarouselSlider(
                  aspectRatio: 2.0/1.0,
                  autoPlay: true,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  pauseAutoPlayOnTouch: Duration(seconds: 3),
                  autoPlayCurve: Curves.bounceOut,
                  items: <Widget>[
                    Container(
                      height: 200.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 5.0,color: Colors.black45,spreadRadius: 5.0)],),
                    ),
                    Container(
                      height: 200.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 5.0,color: Colors.black45,spreadRadius: 5.0)],),
                    ),
                    Container(
                      height: 200.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 5.0,color: Colors.black45,spreadRadius: 5.0)],),
                    ),
                    Container(
                      height: 200.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 5.0,color: Colors.black45,spreadRadius: 5.0)],),
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('laundry_data').snapshots(),
                      builder: (BuildContext context,snapshot){
                        if(snapshot.hasData){
                          List<Container> myList=[];
                          var laundryList = snapshot.data.documents;
                          for(var i in laundryList){
                            var loc = i.data['location'];
                            print(myLocation);
                            if(locationService.getDistance(myLocation,loc)<=5.0 && i.data['laundry_name'].toString().startsWith(search)){
                              myList.add(Container(
                                width: 20.0,
                                height: 20.0,
                                child: Text(i.data['laundry_name']),
                              ));
                            }else{
                              print("far away");
                            }
                          }
                          return ListView(
                            children: myList,
                          );
                        }else{
                          return Container(
                            child: Text('null'),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
