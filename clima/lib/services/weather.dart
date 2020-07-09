import 'package:clima/services/networking.dart';
import 'dart:convert';
import 'package:clima/services/location.dart';


class WeatherModel {

  static String apiKey='f296bc5987e8a760f7afb5328d10216e';
  double latitude=null,longitude=null;

  Future<dynamic> getCityWeather(String cityname)async{
    NetworkHelper networkHelper=NetworkHelper(url:'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apiKey');
    var report=await networkHelper.getData();
    return report;
  }

  Future<dynamic> getLcationWeather() async{
    Location location=Location();
    await location.getLocation();
    latitude=location.lat;
    longitude=location.long;
    NetworkHelper networkHelper=NetworkHelper(url:'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    var  report =await networkHelper.getData();
    return report;
  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
