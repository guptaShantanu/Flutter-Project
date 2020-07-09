import 'package:flutter/material.dart';

class Part1 extends StatefulWidget {
  final key = ValueKey(11);
  @override
  _Part1State createState() => _Part1State();
}

class _Part1State extends State<Part1> {


  List imgUrl_ = [
    'https://images.unsplash.com/photo-1497634763913-2ea08bf9de5d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1511225160131-38607044acc7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjQzMzEwfQ&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1509742389143-62777dbb1fa5?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80",
    "https://images.unsplash.com/photo-1502673530728-f79b4cab31b1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1308&q=80",
    "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80",
    "https://images.unsplash.com/photo-1502673530728-f79b4cab31b1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1308&q=80",
  ];


  List<Widget> myList = [];
  final key = GlobalKey<AnimatedListState>();

  void loadData(){
    var future = Future((){});

    for(int i =0 ; i<20;i++){
      future = future.then((value){
        return Future.delayed(Duration(milliseconds: 100),(){
          myList.add(Row(
            children: <Widget>[
              Text('Feed $i',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),),
              Text(' : '),
              Text('lorem ipsum te doller sit amet')
            ],
          ),);
          key.currentState.insertItem(i,duration: Duration(milliseconds: 100));
        });

      });

    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 150.0,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      offset: Offset(5, 5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SliderCard(imgUrl_: imgUrl_, index: 0),
                  SliderCard(
                    imgUrl_: imgUrl_,
                    index: 1,
                  ),
                  SliderCard(
                    imgUrl_: imgUrl_,
                    index: 2,
                  ),
                  SliderCard(
                    imgUrl_: imgUrl_,
                    index: 3,
                  ),
                  SliderCard(
                    imgUrl_: imgUrl_,
                    index: 4,
                  ),
                  SliderCard(
                    imgUrl_: imgUrl_,
                    index: 5,
                  ),
                ],
              )),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 150.0,
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.0,
                    offset: Offset(5, 5),
                  )
                ],
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex:2,
                    child: Text(
                  'Feeds',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
                )),
                Expanded(
                  flex: 9,
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: AnimatedList(
                      key: key,
                      initialItemCount: myList.length,
                      itemBuilder: (context,index,animation){
                        return FadeTransition(
                          child: myList[index],
                          opacity: animation,

                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliderCard extends StatelessWidget {
  const SliderCard({@required this.imgUrl_, @required this.index});

  final List imgUrl_;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      width: 140.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.black, width: 1.0),
          image: DecorationImage(
              image: NetworkImage(imgUrl_[index]), fit: BoxFit.cover)),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 20.0,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Title $index',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              shadows: [Shadow(color: Colors.black, blurRadius: 2.0)]),
        ),
      ),
    );
  }
}
