import 'package:flutter/material.dart';
import 'package:quizzler/question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MaterialApp(
    home: QuizApp(),
  ));
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  //list which is storing the score
  List<Widget> scoreKeeper = [];

  // list of questions
  QuestionBank qb=QuestionBank();

  // list of answers

  int currentQuestions = 0;


  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "QUIZZLER ALERT",
      desc: "Quiz is over",
      buttons: [
        DialogButton(
          child: Text(
            "RESET",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () { Navigator.pop(context);
          setState(() {
            currentQuestions=0;
          });},
          width: 120,
        )
      ],
    ).show();
  }

  void checkAmswer(bool _answer) {
    if (_answer == qb.qList[currentQuestions].answer) {
      setState(() {
        scoreKeeper.add(new Icon(
          Icons.check,
          color: Colors.green.shade600,
        ));
//          currentQuestions++;
      });
    } else {
      setState(() {
        scoreKeeper.add(new Icon(
          Icons.cancel,
          color: Colors.red.shade600,
        ));
//        currentQuestions++;
      });

    }
    currentQuestions++;
    if (currentQuestions == 3) {
      currentQuestions--;
      _onAlertButtonPressed(context);

    }else{
      setState(() {
        currentQuestions+=0;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    qb.qList[currentQuestions].question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Colors.green.shade600,
                  textColor: Colors.white,
                  child: Text(
                    'TRUE',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  onPressed: () {
                    checkAmswer(true);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Colors.red.shade600,
                  textColor: Colors.white,
                  child: Text(
                    'FALSE',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  onPressed: () {
                    checkAmswer(false);
                  },
                ),
              ),
            ),
            Row(
              children: scoreKeeper,
            )
          ],
        ),
      ),
    );
  }
}
