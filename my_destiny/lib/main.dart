import 'package:flutter/material.dart';
import 'package:my_destiny/Story_brain.dart';

//TODO: Step 15 - Run the app and see if you can see the screen update with the first story. Delete this TODO if it looks as you expected.

void main() => runApp(Destini());

class Destini extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: StoryPage(),
    );
  }
}

Story_brain story_brain=Story_brain();

class StoryPage extends StatefulWidget {
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override

  bool status=true;
  void nextStory(int choiceNum)
  {
    switch(story_brain.currentStory)
    {
      case 0:
        {
          setState(() {
            if(choiceNum==1)
            {
                story_brain.currentStory=2;
            }
            else{
              story_brain.currentStory=1;
            }
          });
          break;
        }
      case 1:
        {
          setState(() {
            if(choiceNum==1)
              {
                story_brain.currentStory=2;
              }
            else{
              story_brain.currentStory=3;
              status=false;
            }
          });
          break;
        }
      case 2:
        {
          setState(() {
            if(choiceNum==1)
            {
              story_brain.currentStory=5;
              status=false;
            }
            else{
              story_brain.currentStory=4;
              status=false;
            }
          });
          break;
        }
      case 3:
        {
          setState(() {
            story_brain.currentStory=0;
            status=true;
          });
          break;
        }
      case 4:
        {
          setState(() {
            story_brain.currentStory=0;
            status=true;
          });
          break;
        }
      case 5:
        {
          setState(() {
            story_brain.currentStory=0;
            status=true;
          });
          break;
        }

    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('images/background.png'),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    story_brain.getStory(),
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  onPressed: () {
                    nextStory(1);
                     },
                  color: Colors.red,
                  child: Text(
                    story_brain.getChoice1(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                //TODO: Step 26 - Use a Flutter Visibility Widget to wrap this FlatButton.
                //TODO: Step 28 - Set the "visible" property of the Visibility Widget to equal the output from the buttonShouldBeVisible() method in the storyBrain.
                child: Visibility(
                  visible: status,
                  child: FlatButton(
                    onPressed: () {
                      nextStory(2);
                      //TODO: Step 19 - Call the nextStory() method from storyBrain and pass the number 2 as the choice made by the user.
                    },
                    color: Colors.blue,
                    child: Text(
                      story_brain.getChoice2(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: Step 24 - Run the app and try to figure out what code you need to add to this file to make the story change when you press on the choice buttons.

//TODO: Step 29 - Run the app and test it against the Story Outline to make sure you've completed all the steps. The code for the completed app can be found here: https://github.com/londonappbrewery/destini-challenge-completed/
