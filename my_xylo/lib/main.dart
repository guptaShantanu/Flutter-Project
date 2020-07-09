import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  var player = AudioCache();

  void playSound(int number)=>player.play('note$number.wav');


  void playSpecialSound(int num1,int num2)
  {
    player.play('note$num1.wav');
    player.play('note$num2.wav');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Piano'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Container(
                            width: double.infinity,
                            color: Colors.red,
                          ),
                          onPressed: (){
                            playSound(1);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.black,
                                  width: double.infinity,
                                ),
                                onPressed: (){
                                  playSpecialSound(1,2);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.red,
                                ),
                                onPressed: (){
                                  playSpecialSound(1,2);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Container(
                            width: double.infinity,
                            color: Colors.green,
                          ),
                          onPressed: (){
                            playSound(2);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.black,
                                  width: double.infinity,
                                ),
                                onPressed: (){
                                  playSpecialSound(2,3);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.green,
                                ),
                                onPressed: (){
                                  playSound(2);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Container(
                            width: double.infinity,
                            color: Colors.blue,
                          ),
                          onPressed: (){
                            playSound(3);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.black,
                                  width: double.infinity,
                                ),
                                onPressed: (){
                                  playSpecialSound(3,4);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.blue,
                                  width: double.infinity,
                                  height: double.infinity,

                                ),
                                onPressed: (){
                                  playSound(3);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Container(
                            width: double.infinity,
                            color: Colors.yellow,
                          ),
                          onPressed: (){
                            playSound(4);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.black,
                                  width: double.infinity,
                                ),
                                onPressed: (){
                                  playSpecialSound(4,5);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.yellow,
                                ),
                                onPressed: (){
                                  playSound(4);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Container(
                            width: double.infinity,
                            color: Colors.tealAccent,
                          ),
                          onPressed: (){
                            playSound(5);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.black,
                                  width: double.infinity,
                                ),
                                onPressed: (){
                                  playSpecialSound(5,6);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.tealAccent,
                                ),
                                onPressed: (){
                                  playSound(5);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Container(
                            width: double.infinity,
                            color: Colors.orange,
                          ),
                          onPressed: (){
                            playSound(6);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.black,
                                  width: double.infinity,
                                ),
                                onPressed: (){
                                  playSpecialSound(6,7);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.orange,
                                ),
                                onPressed: (){
                                  playSound(6);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          child: Container(
                            width: double.infinity,
                            color: Colors.blueGrey,
                          ),
                          onPressed: (){
                            playSound(7);
                          },
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                child: Container(
                                  color: Colors.blueGrey,
                                ),
                                onPressed: (){
                                  playSound(7);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
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
