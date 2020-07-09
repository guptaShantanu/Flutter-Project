import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrkleanownerflutter/widgets/myButton.dart';
import 'package:mrkleanownerflutter/widgets/myTextField.dart';
import 'dart:async';
class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}


class _AddScreenState extends State<AddScreen> {
  //DropDown Menu Item List
  //Type
  List dList = [DropdownMenuItem<String>(child: Text('Regular'), value: 'Regular',),DropdownMenuItem<String>(child: Text('Express'), value: 'Express',)];
  //Category
  List cList = [DropdownMenuItem<String>(child: Text('Men'), value: 'Men',),DropdownMenuItem<String>(child: Text('Women'), value: 'Women',),DropdownMenuItem<String>(child: Text('Kid'), value: 'Kid',),DropdownMenuItem<String>(child: Text('Housing'), value: 'Housing',)];

  List itemList = [];

  String itemName,itemPrice,category="Men",type="Regular",search = "";

  TextEditingController priceTextController = new TextEditingController(),itemNameController = new TextEditingController();
  String myUid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void getUser()async{
    var _auth = FirebaseAuth.instance;
    var user  = await _auth.currentUser();
    myUid = user.uid;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:DropdownButton(
                        onChanged: (value){setState(() {
                          type = value;
                        });},
                      value: type,
                      items: [DropdownMenuItem<String>(child: Text('Regular'), value: 'Regular',),DropdownMenuItem<String>(child: Text('Express'), value: 'Express',)],
                    ), ),
                    SizedBox(width: 5.0,),
                    Expanded(

                      child: DropdownButton(
                        onChanged: (value){setState(() {
                          category = value;
                        });
                        },
                      value: category,
                      items: [DropdownMenuItem<String>(child: Text('Men'), value: 'Men',),DropdownMenuItem<String>(child: Text('Women'), value: 'Women',),DropdownMenuItem<String>(child: Text('Kid'), value: 'Kid',),DropdownMenuItem<String>(child: Text('Housing'), value: 'Housing',)],
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              MyTextField(hint: "ItemName",textController: itemNameController,onChangeFunction: (value){itemName = value;},),
              SizedBox(height: 10.0,),
              MyTextField(hint: "ItemPrice",textController: priceTextController,onChangeFunction: (value){itemPrice = value;},),
              SizedBox(height: 10.0,),
              MyButton(title: 'Add',onTap: (){
                setState(() {
                  itemList.add([itemName,itemPrice]);
                });

                itemNameController.clear();
                priceTextController.clear();
                itemName="";
                itemPrice="";
              },),
              SizedBox(height: 5.0,),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext context,int i){
                        return MyTile(we: itemList[i][0],re: itemList[i][1],onTap: (){setState(() {
                          itemList.removeAt(i);
                        });},);
                    },
                  ),
                ),
              ),
              MyButton(title: 'Final Commit',onTap: ()async{
                    var db = Firestore.instance;

                    DocumentSnapshot snapshot = await db.collection("laundry_service_data").document(myUid).get();
                    print(snapshot.data);
                    List oldList = snapshot.data[type.toLowerCase()+'_'+category.toLowerCase()+'_'+'list'];

                    var tep ={'men':itemList};
                    print(oldList);

                    db.collection('laundry_service_data').document(myUid).updateData({
                      type.toLowerCase()+'_'+category.toLowerCase()+'_'+'list':tep
                    });
              },)

            ],
          ),
        ),
      ),
    );
  }
}


class MyTile extends StatelessWidget {
  final String we,re;
  final Function onTap;
  MyTile({this.we,this.re,this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(re),
      leading:Text(we),
      trailing: GestureDetector(
        child: Icon(Icons.delete,color: Colors.red,),
        onTap: onTap,
      ),);
  }
}

