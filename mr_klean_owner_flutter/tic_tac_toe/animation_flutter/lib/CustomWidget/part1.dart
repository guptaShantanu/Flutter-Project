import 'package:flutter/material.dart';

class Part1 extends StatefulWidget {
  final key = ValueKey(11);
  @override
  _Part1State createState() => _Part1State();
}

class _Part1State extends State<Part1> {
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
                    blurRadius: 5.0, offset: Offset(5, 5),)
                ],
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: <Widget>[

                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(Icons.cloud,color: Colors.blue,size: 60.0,),
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 1.0,
                  color: Colors.blueGrey,
                  margin: EdgeInsets.all(10.0),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('NOIDA, IN',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('50°C',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                            SizedBox(width: 5.0,),
                            Text('Hai garmi !!!',style: TextStyle(color: Colors.blue),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.ac_unit,color: Colors.blue,),
                            SizedBox(width: 5.0,),
                            Text('MIN: 45 MAX: 51',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w600),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.opacity,color: Colors.blue,),
                            SizedBox(width: 5.0,),
                            Text('Humidity : 345.6732',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 150.0,
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0, offset: Offset(5, 5),)
                ],
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0) ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://images.unsplash.com/photo-1500252185289-40ca85eb23a7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=751&q=80'),

                      )
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Title : India attacked on china ...',style: TextStyle(color: Colors.blue,fontSize: 15.0,fontWeight: FontWeight.w600)),
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
