import 'package:flutter/material.dart';

class ThreeDScreen extends StatefulWidget {
  @override
  _ThreeDScreenState createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details){
        setState(() {
          _offset+=details.delta;
        });
      },
      onDoubleTap: (){
        setState(() {
          _offset = Offset.zero;
        });

      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            color: Colors.blueGrey.shade700,
            alignment: Alignment.center,
            child: Transform(
              transform: Matrix4.identity()
              ..setEntry(3, 2, 0.003)
              ..rotateX(0.01*_offset.dy)
              ..rotateY(-0.01*_offset.dx),
              alignment: FractionalOffset.center,
              child: Container(
                height: 100.0,
                width: 100.0,
                color: Colors.white,
                alignment: Alignment.center,
                child: Material(
                  elevation: 30.0,
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    color: Colors.red,
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//Transform(
//transform: Matrix4.identity()
//..setEntry(3, 2, 0.003)
//..rotateX(-3.14/3),
//alignment: Alignment.topCenter,
//child: Container(
//height: 100.0,
//width: 100.0,
//color: Colors.black,
//alignment: Alignment.center,
//child: Container(
//height: 80.0,
//width: 80.0,
//color: Colors.white,
//),
//),
//),