import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrkleanownerflutter/screens/add_screen.dart';
import 'package:mrkleanownerflutter/services/authService.dart';
import 'package:mrkleanownerflutter/services/locationService.dart';
import 'package:mrkleanownerflutter/widgets/myButton.dart';
import 'package:mrkleanownerflutter/widgets/myTextField.dart';



class RegistrationScreen extends StatefulWidget {
  String phoneNo_;
  RegistrationScreen({this.phoneNo_});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String owner_name,owner_upi="",laundry_name,pincode,city,landmark,description,emailId,alt_phoneNo,address,verificationId;
  var phoneNoFieldController = TextEditingController();
  String currentPaymentOption= "Cash On Delivery";
  bool enableUPI=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                      MyTextField(
                          hint: "Laundry Name",
                          icon: Icons.location_city,
                          onChangeFunction: (value) {laundry_name=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Owner Name",
                          icon: Icons.person,
                          onChangeFunction: (value) {owner_name=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: widget.phoneNo_,
                          icon: Icons.call,
                          isActive: false,
                          onChangeFunction: (value) {}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Alternative Contact No",
                          icon: Icons.call,
                          onChangeFunction: (value) {alt_phoneNo=value;}),
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
                          hint: "City",
                          icon: Icons.location_city,
                          onChangeFunction: (value) {city=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Address",
                          icon: Icons.location_on,
                          onChangeFunction: (value) {address=value;}),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "Pincode",
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
                      Text('Payment option for customer',style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15.0,
                      ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 40.0,
                        alignment: Alignment.center,
                        child: DropdownButton(
                          value: currentPaymentOption,
                          items: [DropdownMenuItem<String>(child: Text('UPI Payment'),value: 'UPI Payment',),
                            DropdownMenuItem<String>(child: Text('Cash On Delivery'),value: 'Cash On Delivery'),
                            DropdownMenuItem<String>(child: Text('Both'),value: 'Both',),
                          ], onChanged: (String value) {
                            setState(() {
                              currentPaymentOption = value;
                              if(value == 'Both'||value == 'UPI Payment'){
                                enableUPI=true;
                              }else{
                                enableUPI=false;
                              }
                            });
                        },
                        ),

                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      MyTextField(
                          hint: "OWNER UPI",
                          icon: Icons.comment,
                          isActive: enableUPI,
                          onChangeFunction: (value) {landmark=value;}),
                      MyButton(
                        title: 'Register',
                        onTap: () {
                          startAuthentication(context, widget.phoneNo_);
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
      LocationService location = new LocationService();
      var loctionData = await location.getLocation();
      var db = Firestore.instance;
      var user = await FirebaseAuth.instance.currentUser();
      db.collection("laundry_data").document(user.uid).setData(
        {
          'owner_name':owner_name,
          'laundry_name':laundry_name,
          'city':city,
          'landmark':landmark,
          'address':address,
          'payment_option':currentPaymentOption,
          'merchent_upiId':owner_upi,
          'description':description,
          'phone_no':phoneNo,
          'altPhone_no':alt_phoneNo,
          'emailId':emailId,
          'location':loctionData
        }
      );
      db.collection("laundry_service_data").document(user.uid).setData({
        'uid':user.uid,
        'regular':false,
        'express':false,
        'regular_men_list':[],
        'regular_women_list':[],
        'regular_kids_list':[],
        'regular_housing_list':[],
        'express_women_list':[],
        'express_men_list':[],
        'express_kids_list':[],
        'express_housing_list':[],
        'regular_min_price':50,
        'express_min_price':100,
      });
      db.collection('registered_user').document(widget.phoneNo_).setData({'isRegister':true});
      var res = await AuthService.checkUserExistance(widget.phoneNo_);
      if(res){
        print("Registration success");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddScreen();
        }));
      }else{
        print("Registration failed");
      }

  }



}
