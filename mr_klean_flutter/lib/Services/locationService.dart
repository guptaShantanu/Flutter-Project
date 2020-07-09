import 'package:geolocator/geolocator.dart';
import 'dart:math';

class LocationService{

  Future<List<double>> getLocation() async{
    Position co_ordinates = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    return [co_ordinates.latitude,co_ordinates.longitude];

  }

  double getDistance(var location1,var location2){
    var R = 6371;
    var dLat = deg_to_rad(location2[0]-location1[0]);
    var dLon = deg_to_rad(location2[1]-location1[1]);
    var a = sin(dLat/2)*sin(dLat/2)+cos(deg_to_rad(location1[0]))*cos(deg_to_rad(location2[0]))*sin(dLon/2)*sin(dLon/2);
    var c = 2*atan2(sqrt(a), sqrt(1-a));
    var d = R*c;
    return d;
  }

  double deg_to_rad(deg){
    return deg*(pi/180);
  }

}