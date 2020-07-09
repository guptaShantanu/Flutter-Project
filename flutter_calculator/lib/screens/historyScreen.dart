import 'package:flutter/material.dart';
import 'package:fluttercalculator/history_data.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {


  List<Widget> getItem(){
    List<Widget> itemList=[];
    for(int i=expressions.length-1;i>=0;i--){
        itemList.add(
          new ListItem(expression: expressions[i],result: results[i],function: (){
            Navigator.pop(context,[expressions[i],results[i]]);
          })
        );
    }
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: ListView(
            children: getItem(),
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {

    String expression,result;
    Function function;
    ListItem({this.expression,this.result,this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  expression,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              IconButton(
                hoverColor: Colors.black,
                  icon: Icon(
                Icons.trending_up,
                color: Colors.white,
              ), onPressed: function
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 1.0,
            child: Container(
              color: Colors.blueGrey.shade800,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            result,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
