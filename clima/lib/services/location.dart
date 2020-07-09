import 'package:geolocator/geolocator.dart';

class Location{
   double lat=null;
   double long=null;


  void getLocation () async {
    try{
      print("hello user");
      Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      lat=position.latitude;
      long=position.longitude;
      print(lat);
      print(long);
      print(position);
    }catch(e){
      print(e);
    }
  }




}