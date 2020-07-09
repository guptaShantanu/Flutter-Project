import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {

  var weatherData;
  LocationScreen({this.weatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int temperature;
  int condition;
  String name;
  String icon;
  String tagLine;
  WeatherModel weatherModel;

  @override
  void initState() {
    super.initState();

    updateUI(widget.weatherData);
  }


  void updateUI(dynamic weatherData){
        setState(() {
          if (weatherData!=null) {
            name = weatherData["name"];
            double temp = weatherData["main"]["temp"];
            temperature = temp.toInt() - 273;
            condition = weatherData["weather"][0]["id"];
            weatherModel = WeatherModel();
            icon = weatherModel.getWeatherIcon(condition);
            tagLine = weatherModel.getMessage(temp.toInt() - 273);
          }
          else{
            setState(() {
            name='Error';
            temperature=0;
            icon='error';
            tagLine='Unable to get data';
            });
          }
        });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{

                      var report=await weatherModel.getLcationWeather();
                      setState(() {
                        updateUI(report);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var cityName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print("hbshuchifhciec $cityName");
                      if (cityName!=null){
                        var report=await weatherModel.getCityWeather(cityName);
                        updateUI(report);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$tagLine in $name',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
