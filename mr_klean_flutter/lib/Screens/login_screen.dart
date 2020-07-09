import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mrkleanflutter/Screens/laundry_list_screen.dart';
import 'package:mrkleanflutter/Screens/registration_screen.dart';
import 'package:mrkleanflutter/Services/authService.dart';
import 'package:mrkleanflutter/Widgets/myButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo, verificationId, smsCode;
  bool newUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'splash_icon',
                child: Icon(
                  Icons.ac_unit,
                  size: 150.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black)],
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '+91',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                            width: 250.0,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                phoneNo = value;
                              },
                              style: TextStyle(fontSize: 20.0),
                              decoration: InputDecoration(),
                            )),
                      ],
                    ),
                  ),
                  MyButton(
                    title: 'Login',
                    onTap: () {
                        startLoginService(context,phoneNo);
                    },
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RegistrationScreen();
                          }));
                        },
                          child: Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.w900),
                  ))),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> startLoginService(context,phoneNo)async{
    var db = Firestore.instance;
    var snapshot = await db.collection('registered_user').document('$phoneNo').get();
    if(snapshot.data == null){
      print('Users does not exist');
      newUser = true;
      startPhoneAuthentication(phoneNo);
    }else{
      print('Users exist');
      newUser = false;
      startPhoneAuthentication(phoneNo);
    }

//    if(snapshot.)


//    showModalBottomSheet(
//        context: context,
//        builder: (context) {
//          return Container(
//            color: Colors.lightBlueAccent,
//          );
//        });
  }

  Future<void> startPhoneAuthentication(String phone) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) async{
     var res= await AuthService.signIn(authResult, context);
     if(res){
       if(newUser){
         Navigator.push(context,MaterialPageRoute(builder: (context){
           return RegistrationScreen(phoneNo_: phoneNo);
         }));
       }else{
         Navigator.push(context,MaterialPageRoute(builder: (context){
           return LaundryListScreen();
         }));
       }
     }
//      print("Auth successful");
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}' + 'Failed');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
//        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
