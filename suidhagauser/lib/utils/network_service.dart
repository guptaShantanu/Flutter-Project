import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

import 'package:user/utils/urls.dart';


class NetworkService {
  String baseUrl = "https://sui-dhaga-backend.herokuapp.com/api";

  Future<bool> initiateUrl() async {
    try {
      Response response = await http.get(baseUrl + '/getUrls');
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        URL.url1 = body['url1'];
        URL.url2 = body['url2'];
        URL.url3 = body['url3'];
        URL.url4 = body['url4'];
        URL.url5 = body['url5'];
        URL.url6 = body['url6'];
      } else {
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
