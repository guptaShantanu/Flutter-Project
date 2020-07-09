import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/Modal/authfile.dart';
import 'package:urbanridertest/Screens/main_screen.dart';
import 'package:urbanridertest/Services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void page1func(){
    setState(() {
      currentWidget = AuthPage1();
    });
  }

  void page2func(){
    setState(() {
      currentWidget = AuthPage2();
    });
  }

  void page3func(){
    setState(() {
      currentWidget = AuthPage3(ontap: (){},);
    });
  }

  Widget currentWidget;

  @override
  void initState() {
    currentWidget = AuthPage1(ontap: (){
      setState(() {
        currentWidget = AuthPage2(ontap: page3func,);
      });
    },);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: AnimatedSwitcher(
          child: currentWidget,
          duration: Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class AuthPage1 extends StatefulWidget {
  final Function ontap;
  AuthPage1({this.ontap});

  @override
  _AuthPage1State createState() => _AuthPage1State();
}

class _AuthPage1State extends State<AuthPage1> {

  String phoneNo, verificationId, smsCode;

  @override
  void initState() {
    super.initState();
  }



  Future<void> startPhoneAuthentication(String phone) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) async{
      var res= await AuthService.signIn(authResult, context);
      if(res){
        widget.ontap();
      }else{
        print("Authentication failed");
      }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: TextField(
                    onChanged: (val){
                      KKphoneno = val;
                    },
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Color.fromRGBO(166,166,166,1.0)),
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1,child: Container(child: Icon(Icons.phone,color: Color.fromRGBO(166,166,166,1.0),)))
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: TextField(
                    maxLength: 6,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      labelStyle: TextStyle(color: Color.fromRGBO(166,166,166,1.0)),
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1,child: Container(child: Icon(Icons.code,color: Color.fromRGBO(166,166,166,1.0),)))
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            onPressed: (){
              startPhoneAuthentication(KKphoneno);
            },
            elevation: 10.0,
            splashColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color.fromRGBO(166,166,166,1.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthPage2 extends StatefulWidget {

  final Function ontap;
  AuthPage2({this.ontap});




  @override
  _AuthPage2State createState() => _AuthPage2State();
}

class _AuthPage2State extends State<AuthPage2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = KKname;
    passwordController.text = KKpassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: TextField(
                    controller: nameController,
                    onChanged: (val){
                      KKname = val;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Color.fromRGBO(166,166,166,1.0)),
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1,child: Container(child: Icon(Icons.person,color: Color.fromRGBO(166,166,166,1.0),)))
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: TextField(
                    onChanged: (val){
                      KKpassword = val;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color.fromRGBO(166,166,166,1.0)),
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1,child: Container(child: Icon(Icons.lock,color: Color.fromRGBO(166,166,166,1.0),)))
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            onPressed: (){
              widget.ontap();
              },
            elevation: 10.0,
            splashColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color.fromRGBO(166,166,166,1.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: Text(
                'Create account',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthPage3 extends StatefulWidget {

  final Function ontap;
  AuthPage3({this.ontap});

  @override
  _AuthPage3State createState() => _AuthPage3State();
}

class _AuthPage3State extends State<AuthPage3> {

  TextEditingController handleNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handleNameController.text = KKhandleName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: TextField(
                    onChanged: (val){
                      KKhandleName = val;
                    },
                    decoration: InputDecoration(
                      labelText: '@Handle name',
                      labelStyle: TextStyle(color: Color.fromRGBO(166,166,166,1.0)),
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1,child: Container(child: Icon(Icons.person_outline,color: Color.fromRGBO(166,166,166,1.0),)))
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            onPressed: ()async{
              var res = await AuthService.createUser(KKname, KKphoneno, KKpassword, KKhandleName);
              if(res[0]){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>MainScreen()));
              }else{
                print(res[1]);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Try another handle name',),
                  duration: Duration(seconds: 3),
                ));
              }
            },
            elevation: 10.0,
            splashColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color.fromRGBO(166,166,166,1.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: Text(
                'Create account',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
