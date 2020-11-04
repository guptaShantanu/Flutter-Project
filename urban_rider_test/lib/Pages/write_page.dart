import 'package:flutter/material.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/Services/database_service.dart';


class WritePage extends StatelessWidget {
  String story = "";
  TextEditingController storyTextController = TextEditingController();

  void saveStory(){
    DatabaseService databaseService = DatabaseService();
    databaseService.saveStory(story);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: storyTextController,
            onChanged: (val){
              story = val;
            },
            maxLength: 15,
            cursorColor: KMainThemeColors,
            decoration: InputDecoration(
                hintText: 'What\'s your fav quote?',
              border: null,
              fillColor: KMainThemeColors,
              hoverColor: KMainThemeColors,
              focusColor: KMainThemeColors,
              counterStyle: TextStyle(fontSize: 15.0)

            ),

          ),
          SizedBox(height: 20.0,),
          RaisedButton(
            shape: CircleBorder(
                side: BorderSide(width: 0.0,color: Colors.transparent)
            ),
            child: Container(
                height: 60.0,
                width: 60.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.send,color: KMainThemeColors,size: 35.0,)),
            color: Colors.white,
            onPressed: (){
              saveStory();
            },
          )
        ],
      ),
    );
  }
}

