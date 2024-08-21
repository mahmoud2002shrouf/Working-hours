 import 'package:employees_attendance/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

class LocationServese{
  Location location=Location();
  late LocationData _locData;
  Future<Map<String,double?>?> getLocation(BuildContext context)async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled=await location.serviceEnabled();
    if(!serviceEnabled){
      Utils.showSnackBar("Please enable location services", context);
      return null;

    }
    permissionGranted=await location.hasPermission();
    if(permissionGranted==PermissionStatus.denied){
      permissionGranted=await location.requestPermission();
      if(permissionGranted!=PermissionStatus.granted){
        Utils.showSnackBar("Please allow location access", context);
        return null;
      }
    }
    _locData=await location.getLocation();
    return {
      "latitude":_locData.latitude,
      "longitude":_locData.longitude
    };



  } }