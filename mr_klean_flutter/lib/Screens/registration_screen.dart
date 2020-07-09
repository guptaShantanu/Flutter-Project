import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrkleanflutter/Screens/laundry_list_screen.dart';
import 'package:mrkleanflutter/Screens/login_screen.dart';
import 'package:mrkleanflutter/Services/authService.dart';
import 'package:mrkleanflutter/Widgets/myTextField.dart';
import 'package:mrkleanflutter/Widgets/myButton.dart';

class RegistrationScreen extends StatefulWidget {
  String phoneNo_;
  RegistrationScreen({this.phoneNo_});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name,phoneNo,address,flatNo,pincode,emailId,landmark,verificationId;
  var phoneNoFieldController = TextEditingController();
  var uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void getUser()async{
    var user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(
          'Mr Klean',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.lightBlueAccent,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(15.0),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black)],
                color: Colors.white,
              ),
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: ListView(
                    children: <Widget>[
                      Text('User Information',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.lightBlueAccent,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800
                        ),),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Username",
                          icon: Icons.person,
                          onChangeFunction: (value) {name=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Email Id",
                          icon: Icons.mail,
                          onChangeFunction: (value) {emailId=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: widget.phoneNo_,
                          icon: Icons.call,
                          isActive: false,
                          onChangeFunction: (value) {phoneNo=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Address",
                          icon: Icons.location_city,
                          onChangeFunction: (value) {address=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Flat number",
                          icon: Icons.home,
                          onChangeFunction: (value) {flatNo=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "PINCODE",
                          icon: Icons.location_on,
                          onChangeFunction: (value) {pincode=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Landmark",
                          icon: Icons.local_shipping,
                          onChangeFunction: (value) {landmark=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyButton(
                        title: 'Register',
                        onTap: () {
                          startAuthentication(context, phoneNo);
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container();
                              });
                        },
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                              child: Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.w900),
                      ))),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
  void startAuthentication(context,phoneNo)async {
      var db = Firestore.instance;
      var user = await FirebaseAuth.instance.currentUser();
      db.collection("user_data").document(user.uid).setData(
        {'name':name,
          'emailId':emailId,
          'phoneNo':widget.phoneNo_,
          'pincode':pincode,
          'address':address,
          'landmark':landmark,
          'flatNo':flatNo,
          'uid':uid,
        }
      );
      db.collection('registered_user').document(widget.phoneNo_).setData({'isRegister':true});
      var res = await AuthService.checkUserExistance(widget.phoneNo_);
      if(res){
        print("Registration success");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LaundryListScreen();
        }));
      }else{
        print("Registration failed");
      }

  }



}
