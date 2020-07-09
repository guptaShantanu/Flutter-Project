import 'package:flutter/material.dart';

class Animation3 extends StatefulWidget {
  @override
  _Animation3State createState() => _Animation3State();
}

class _Animation3State extends State<Animation3> with SingleTickerProviderStateMixin{
  AnimationController animationController;

  bool _canBeDragged = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
//    animation = CurvedAnimation(parent: animationController,curve: Curves.linear);
    Future.delayed(Duration(seconds: 3),(){start();});
  }

  void onDragStart(DragStartDetails details){
//    print(details.globalPosition.dy);
    bool isDragFromUp = animationController.isDismissed && details.globalPosition.dx> 10.0;
    bool isDragFromDown = animationController.isCompleted && details.globalPosition.dx< 320.0;

    _canBeDragged =  isDragFromDown||isDragFromUp;
  }

  void onDragUpdate(DragUpdateDetails details){
    if(_canBeDragged){
      double dragDelta = details.primaryDelta/310.0;
      print(details.primaryDelta);
      setState(() {
      animationController.value += dragDelta;
      });
    }
  }

  void start(){
    animationController.forward(from: 0.0);
    animationController.addListener(() { setState(() {

    });});
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: (){
            start();
          },
          onHorizontalDragStart: onDragStart,
          onHorizontalDragUpdate: onDragUpdate,
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(260*animationController.value,0),
                child: Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(0.0-3.14/2*(animationController.value)),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.red,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(-260*(1-animationController.value),0),
                child: Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(3.14/2-(3.14/2*animationController.value)),
                  child: Container(
                    height: double.infinity,
                    width: 260.0,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}
