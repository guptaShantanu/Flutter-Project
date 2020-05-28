import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(PlayBoard());

class PlayBoard extends StatefulWidget {
  @override
  _PlayBoardState createState() => _PlayBoardState();
}

class _PlayBoardState extends State<PlayBoard> {
  //Snake data
  List<int> snake = [55, 75, 95, 115, 135];
  var snakeDirection = 'S';

  //Food Data
  int foodIndex = Random().nextInt(700);

  //Game Data
  int gameSpeed = 200;
  Timer timer;


  //Player Data
  int score = 1;

  //Snake Control
  void startGame() {
     timer = Timer.periodic(Duration(milliseconds: gameSpeed), (Timer timer) {
      moveSnake();
    });

  }

  void moveSnake() {
    setState(() {
      switch (snakeDirection) {
        case 'N':
          {
            int len = snake.length;

            if (snake[len - 1] == foodIndex) {
              score += 1;
              snake.add(foodIndex);
              foodIndex = Random().nextInt(700);
              if (score % 5 == 0) {
                gameSpeed -= 50;
              }
            }
            len = snake.length;
            if (snake[len - 1] < 20) {
              snake.add(700 - (20-snake[len - 1]));
            } else {
              snake.add(snake[len - 1] - 20);
            }

            snake.removeAt(0);
          }
          break;
        case 'S':
          {
            int len = snake.length;

            if (snake[len - 1] == foodIndex) {
              score += 1;
              snake.add(foodIndex);
              foodIndex = Random().nextInt(700);
              if (score % 5 == 0) {
                gameSpeed -= 50;
              }
            }
            len = snake.length;
            if (snake[len - 1] > 679) {
              snake.add(snake[len - 1] % 20);
            } else {
              snake.add(snake[len - 1] + 20);
            }

            snake.removeAt(0);
          }
          break;
        case 'E':
          {
            int len = snake.length;

            if (snake[len - 1] == foodIndex) {
              score += 1;
              snake.add(foodIndex);
              foodIndex = Random().nextInt(700);
              if (score % 5 == 0) {
                gameSpeed -= 50;
              }
            }
            len = snake.length;
            if (snake[len - 1] % 20 == 19) {
              snake.add(snake[len - 1] - 19);
            } else {
              snake.add(snake[len - 1] + 1);
            }

            snake.removeAt(0);
          }
          break;
        case 'W':
          {
            int len = snake.length;

            if (snake[len - 1] == foodIndex) {
              score += 1;
              snake.add(foodIndex);
              foodIndex = Random().nextInt(700);
              if (score % 5 == 0) {
                gameSpeed -= 50;
              }
            }
            len = snake.length;
            if (snake[len - 1] % 20 == 0) {
              snake.add(snake[len - 1] + 19);
            } else {
              snake.add(snake[len - 1] - 1);
            }

            snake.removeAt(0);
          }
          break;
      }
      if (snake
          .sublist(0, snake.length - 1)
          .contains(snake[snake.length - 1])) {
        var n = snake.indexOf(snake[snake.length - 1]);
        snake = snake.sublist(n + 1, snake.length);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left:25.0,right: 25.0,top: 25.0,bottom: 15.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10.0,
                    offset: Offset(10, 10)),
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10.0,
                    offset: Offset(-10, -10)),
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10.0,
                    offset: Offset(10, -10)),
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10.0,
                    offset: Offset(-10, 10)),
              ]),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragUpdate: (direction) {
                        if (snakeDirection != 'W' && direction.delta.dx > 0) {
                          snakeDirection = 'E';
                          print('East');
                        } else if (snakeDirection != 'E' &&
                            direction.delta.dx < 0) {
                          snakeDirection = 'W';
                          print('West');
                        }
                      },
                      onVerticalDragUpdate: (direction) {
                        if (snakeDirection != 'N' && direction.delta.dy > 0) {
                          snakeDirection = 'S';
                          print('East');
                        } else if (snakeDirection != 'S' &&
                            direction.delta.dy < 0) {
                          snakeDirection = 'N';
                          print('West');
                        }
                      },
                      child: GridView.builder(
                          itemCount: 700,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 20),
                          itemBuilder: (BuildContext context, int index) {
                            if (snake.contains(index)) {
                              return Container(
                                margin: EdgeInsets.all(0.5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(2.0)),
                                child: Text(':',textAlign: TextAlign.center,),
                              );
                            } else if (index == foodIndex) {
                              return Container(
                                margin: EdgeInsets.all(0.5),
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    boxShadow: [BoxShadow(blurRadius: 2.0,color: Colors.black45)],
                                    borderRadius: BorderRadius.circular(8.0)),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.all(0.5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0)),
                              );
                            }
                          }),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 40.0,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                             if(timer == null){
                               startGame();
                             }else{
                               if(timer.isActive){
                                 print("Timer is active");
                               }else{
                                 startGame();
                               }
                             }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [BoxShadow(color: Colors.blueGrey,blurRadius: 3.0)]
                              ),
                              child: Text('Start',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Text((score-1).toString(),style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              timer.cancel();
                              setState(() {
                                snake = [55,75,95,115,135];
                                snakeDirection = 'S';
                                score = 0;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade700,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [BoxShadow(color: Colors.blueGrey,blurRadius: 3.0)]
                              ),
                              child: Text('Reset',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
