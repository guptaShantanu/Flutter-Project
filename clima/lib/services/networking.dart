import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper{
  NetworkHelper({this.url});

  final String url;


    Future getData() async{
    Response response=await get(url);

    var weatherReport=jsonDecode(response.body);
    print(weatherReport["name"]);
    return weatherReport;
  }
}