import 'package:geolocator/geolocator.dart';

class LocationService{

  Future<List<double>> getLocation() async{
    Position co_ordinates = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<double> res = [];
    res.add(co_ordinates.latitude);
    res.add(co_ordinates.longitude);

    return res;

  }

}