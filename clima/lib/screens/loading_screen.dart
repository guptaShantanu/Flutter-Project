import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';






class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {

    getLocationData();
  }

  void getLocationData () async {

    WeatherModel weatherModel=new WeatherModel();
    var report = await weatherModel.getLcationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherData: report);
    }));



  }





//  void getData() async{
//    Response response=await get('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
//
//    if (response.statusCode==200){
//        print(jsonDecode(response.body)["name"]);
//        print(jsonDecode(response.body)["main"]["temp"]);
//        print(jsonDecode(response.body)["wind"]["speed"]);
//    }else{
//      print(response.statusCode);
//      print("failed request");
//    }
//  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourglass(color: Colors.white,
        size: 100.0,),
      ),
    );
  }
}
