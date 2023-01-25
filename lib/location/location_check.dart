import 'package:flutter/material.dart';
import 'package:flutterrun/location/map_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';




class LocationCheck extends StatelessWidget {

  Position? position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: ElevatedButton(
                onPressed: () async{
                  LocationPermission  permission = await Geolocator.requestPermission();

                  if(permission == LocationPermission.denied){
                    permission = await Geolocator.requestPermission();
                  }else if(permission == LocationPermission.deniedForever){
                    await Geolocator.openAppSettings();
                  }else if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
                    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                    if(position !=null){
                      // List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
                      // print(placemarks);
                      Get.to(() => MapSample(position!.latitude, position!.longitude), transition:  Transition.leftToRight);
                    }
                  }
                },
                child: Text('location check')
            ),
          ),
        )
    );
  }
}
