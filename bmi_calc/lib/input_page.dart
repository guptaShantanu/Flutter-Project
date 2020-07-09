import 'package:bmi_calc/constant.dart' as prefix0;
import 'package:bmi_calc/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constant.dart';
import 'package:bmi_calc/RoundButton.dart';
import 'bottom_button.dart';
import 'CardView.dart';
import 'childCard.dart';
import 'result_page.dart';
import 'calculation.dart';


Gender currentGender;



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final containerHeight = 80.0;

    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          title: Text('BMI'),
          backgroundColor: Colors.blueGrey.shade800,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new CardView(
                          onPress: () {
                            setState(() {
                              currentGender = Gender.male;
                            });
                          },
                          color:
                          currentGender == Gender.male ? active : inActive,
                          childcard: new ChildCard(
                            icon: FontAwesomeIcons.mars,
                            label: "Male",
                          ),
                        ),
                      ),
                      Expanded(
                        child: new CardView(
                          onPress: () {
                            setState(() {
                              currentGender = Gender.female;
                            });
                          },
                          color: currentGender == Gender.female
                              ? active
                              : inActive,
                          childcard: new ChildCard(
                            icon: FontAwesomeIcons.venus,
                            label: "Female",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: new CardView(
                    color: Colors.blueGrey.shade800,
                    childcard: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'HEIGHT',
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xFF8D8E98)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              height.toString(),
                              style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'CM',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            )
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              inactiveTickMarkColor: Colors.blueGrey.shade400,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 20.0),
                              thumbColor: Colors.red,
                              overlayColor: Colors.red.shade100,
                              activeTrackColor: Colors.white),
                          child: Slider(
                            value: height.toDouble(),
                            min: 60.0,
                            max: 250.0,
                            inactiveColor: Colors.blueGrey.shade500,
                            onChanged: (double newVal) {
                              setState(() {
                                height = newVal.round();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new CardView(
                            color: Colors.blueGrey.shade800,
                            childcard: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'WEIGHT',
                                  style: smallTextStyle,
                                ),
                                Text(
                                  weight.toString(),
                                  style: bigTextStyle,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RoundIconButton(
                                      child: Icons.add,
                                      onPress: () {
                                        setState(() {
                                          weight++;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    RoundIconButton(
                                      child: FontAwesomeIcons.minus,
                                      onPress: () {
                                        setState(() {
                                          weight--;
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        child: new CardView(
                          color: Colors.blueGrey.shade800,
                          childcard: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'AGE',
                                style: smallTextStyle,
                              ),
                              Text(
                                age.toString(),
                                style: bigTextStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RoundIconButton(
                                    child: Icons.add,
                                    onPress: () {
                                      setState(() {
                                        age++;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  RoundIconButton(
                                    child: FontAwesomeIcons.minus,
                                    onPress: () {
                                      setState(() {
                                        age--;
                                      });
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                new BottomButton(
                  title: "Calculate",
                  onTap: () {
                    Calculate c=Calculate(weight: weight,height: height);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Result_Page(bmi: c.findBMI(),result: c.getResult(),inerpretation: c.getInterpretation(),)));
                  },
                )
              ],
            ),
          ),
        ),
    );
  }
}
