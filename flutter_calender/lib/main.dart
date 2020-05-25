import 'package:flutter/material.dart';

void main() => runApp(CalenderApp());


class CalenderApp extends StatefulWidget {
  @override
  _CalenderAppState createState() => _CalenderAppState();
}

class _CalenderAppState extends State<CalenderApp> with TickerProviderStateMixin{
  AnimationController upperPageController,lowerPageController;
  Animation upperPageAnimation,lowerPageAnimation;
  List<Widget> upperPages=[],lowerPages=[];
  static double pi = 3.1415926;
  List<double> upperPageAngle=[0,0,0,0,0,0,0,0,0,0];
  List<double> lowerPageAngle=[pi/2,pi/2,pi/2,pi/2,pi/2,pi/2,pi/2,pi/2,pi/2,pi/2,];
  int currentTarget = 9;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    upperPageController = new AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
//    upperPageAnimation = new CurvedAnimation(parent: upperPageController, curve: Curves.linear);

    lowerPageController = new AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    lowerPageAnimation = new CurvedAnimation(parent: lowerPageController, curve: Curves.linear);
    print(lowerPages);
    print(upperPages);
  }

  void startFirstAnimation(int index) async{
    upperPageController = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    upperPageAnimation = new CurvedAnimation(parent: upperPageController, curve: Curves.linear);

    upperPageController.forward(from: 0.0);
        upperPageAnimation.addListener((){
          print(upperPageAnimation.value);
          var k = upperPageAnimation.value;
          setState(() {
            upperPageAngle[index]=pi/180*k*90;
            if(upperPageAnimation.value==1.0){
              print("gooootcha");
              upperPageController.dispose();

              startSecondAnimation(index-1);
              return;
            }
          });
        });
  }

  void startSecondAnimation(int index) async{
    lowerPageController = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    lowerPageAnimation = new CurvedAnimation(parent: lowerPageController, curve: Curves.bounceIn);

    lowerPageController.reverse(from: 1.0);
    lowerPageAnimation.addListener((){
      print(lowerPageAnimation.value);
      var k = lowerPageAnimation.value;
      setState(() {
        lowerPageAngle[index]=pi/180*k*90*-1;
        if(lowerPageAnimation.value==1.0){
          print("gooootcha");
          lowerPageController.dispose();
          return;
        }
      });
    });
  }






  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: (){
            startFirstAnimation(currentTarget);
            currentTarget-=1;
//            upperPageAngle[currentTarget] = 3.14/2;
          },
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    MyTopRect(angle: upperPageAngle[0],i: 9,),
                    MyTopRect(angle: upperPageAngle[1],i: 8,),
                    MyTopRect(angle: upperPageAngle[2],i: 7,),
                    MyTopRect(angle: upperPageAngle[3],i: 6,),
                    MyTopRect(angle: upperPageAngle[4],i: 5,),
                    MyTopRect(angle: upperPageAngle[5],i: 4,),
                    MyTopRect(angle: upperPageAngle[6],i: 3,),
                    MyTopRect(angle: upperPageAngle[7],i: 2,),
                    MyTopRect(angle: upperPageAngle[8],i: 1,),
                    MyTopRect(angle: upperPageAngle[9],i: 0,),
                  ],
                ),
                SizedBox(height: 5.0,),
                Stack(
                  children: <Widget>[
                    MyBottomRect(angle: 0.0,i: 0,),
                    MyBottomRect(angle: lowerPageAngle[8],i: 1,),
                    MyBottomRect(angle: lowerPageAngle[7],i: 2,),
                    MyBottomRect(angle: lowerPageAngle[6],i: 3,),
                    MyBottomRect(angle: lowerPageAngle[5],i: 4,),
                    MyBottomRect(angle: lowerPageAngle[4],i: 5,),
                    MyBottomRect(angle: lowerPageAngle[3],i: 6,),
                    MyBottomRect(angle: lowerPageAngle[2],i: 7,),
                    MyBottomRect(angle: lowerPageAngle[1],i: 8,),
                    MyBottomRect(angle: lowerPageAngle[0],i: 9,),
                  ],
                ),
                SizedBox(height: 10.0,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBottomRect extends StatelessWidget {
  const MyBottomRect({
    Key key,
    @required this.angle,
    @required this.i,
  }) : super(key: key);

  final double angle;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.003)
        ..rotateX(angle),
      alignment: Alignment.topCenter,
      child: ClipRect(
        child: Align(
          alignment: Alignment.bottomCenter,
          heightFactor: 0.5,
          child: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black,width: 1.0),
                boxShadow: [BoxShadow(blurRadius: 4.0,color: Colors.black12)],
                borderRadius: BorderRadius.circular(10.0)
            ),
            height: 200.0,
            width: 100.0,

            alignment: Alignment.center,
            child: Text((i).toString(),style: TextStyle(fontSize: 100.0),),
          ),
        ),
      ),
    );
  }
}

class MyTopRect extends StatelessWidget {
  const MyTopRect({
    Key key,
    @required this.angle,
    @required this.i,
  }) : super(key: key);

  final double angle;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.003)
        ..rotateX(angle),
      alignment: Alignment.bottomCenter,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 0.5,
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black,width: 1.0),
                boxShadow: [BoxShadow(blurRadius: 4.0,color: Colors.black12)],
              borderRadius: BorderRadius.circular(10.0)
            ),
            height: 200.0,
            width: 100.0,
            alignment: Alignment.center,
            child: Text((i).toString(),style: TextStyle(fontSize: 100.0),),
          ),
        ),
      ),
    );
  }
}
