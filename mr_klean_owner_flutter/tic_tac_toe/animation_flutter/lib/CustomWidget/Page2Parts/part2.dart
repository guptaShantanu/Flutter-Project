import 'package:flutter/material.dart';

class Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<Part2> {
  ScrollController scrollController = new ScrollController();
  var myKey = GlobalKey<AnimatedListState>();
  List<Widget> myList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100),(){
      loadData();
    });

  }

  void loadData(){
    var future = Future((){});

    for(int i =0 ; i<10;i++){
      future = future.then((value){
        return Future.delayed(Duration(milliseconds: 100),(){
          myList.add(Container(
            width: double.infinity,
            height: 50.0,
            margin: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade50,Colors.white,],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.7,0.4]
              ),
              border: Border.all(width: 1.0,color: Colors.black),
              boxShadow: [BoxShadow(offset: Offset(2,2),color: Colors.black,blurRadius: 2.0,)],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),bottomLeft: Radius.circular(5.0))
            ),
          ));
          myKey.currentState.insertItem(i,duration: Duration(milliseconds: 100));
        });

      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: AnimatedList(
        key: myKey,
        controller: scrollController,
        initialItemCount: myList.length,
        itemBuilder: (context,index,animation){
          final fromRightAnimation = Tween<Offset>(begin: Offset(1,0),end: Offset(0,0),).animate(animation);
          return SlideTransition(
            child: myList[index],
            position: fromRightAnimation,

          );
        },
      ),
    );
  }
}
