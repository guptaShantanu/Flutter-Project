import 'package:flutter/material.dart';

class Animation2 extends StatefulWidget {
  @override
  _Animation2State createState() => _Animation2State();
}

class _Animation2State extends State<Animation2> with SingleTickerProviderStateMixin {
  TextStyle drawerItemStyle = TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w300);
  AnimationController animationController;
  Animation animation;
  double currentValue = 0.0;
  bool _canBeDragged = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 200));
//    animation = CurvedAnimation(parent: animationController,curve: Curves.linear);
  animationController.value =  0.0;
  }

  void showMyMenu(){

    animationController.forward(from: 0.0);
    animationController.addListener(() {
      currentValue = animationController.value;
      setState(() {

      });
    });
//    animation.addListener(() {
//      setState(() {
//
//      });
//    });
  }

  void closeMyMenu(){
    animationController.reverse(from: currentValue);
    animationController.addListener(() {
      setState(() {

      });
    });
  }

  void onDragStart(DragStartDetails details){
//    print(details.globalPosition.dy);
    bool isDragFromUp = animationController.isDismissed && details.globalPosition.dy< 50.0;
    bool isDragFromDown = animationController.isCompleted && details.globalPosition.dy< 400.0;

    _canBeDragged =  isDragFromDown||isDragFromUp;
  }

  void onDragUpdate(DragUpdateDetails details){
    if(_canBeDragged){
      double dragDelta = details.primaryDelta/310.0;
      print(details.primaryDelta);
//      setState(() {
        animationController.value += dragDelta;
//      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onVerticalDragStart: onDragStart,
        onVerticalDragUpdate: onDragUpdate,
        onVerticalDragEnd: (det){
//          animationController.value = 1.0;
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.amber,
                  elevation: 0,
                  actions: <Widget>[
                    IconButton(onPressed: closeMyMenu,icon: Icon(Icons.backspace,color: Colors.white,),)
                  ],
                ),
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Menu',style:drawerItemStyle ),
                      SizedBox(height: 10.0,),
                      Text('Profile',style:drawerItemStyle),
                      SizedBox(height: 10.0,),
                      Text('Setting',style:drawerItemStyle),
                      SizedBox(height: 10.0,),
                      Text('Logout',style:drawerItemStyle),
                    ],
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: animationController,
                builder: (context,_){
                  return Transform(
                    transform: Matrix4.identity()
                      ..scale(1.0,1.0)
                      ..translate(0.0,animationController.value*250.0,),
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(leading: IconButton(onPressed:showMyMenu,icon: Icon(Icons.menu,color: Colors.white,),),),
                      body: Container(
                        alignment: Alignment.center,
                        child: Text('Hello world!'),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
    ),
      ),
    );
  }
}
