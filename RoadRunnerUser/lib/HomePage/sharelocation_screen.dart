import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/share.dart';


class ShareLocationScreen extends StatefulWidget{
  ShareLocationScreenState createState()=> ShareLocationScreenState();
}
class ShareLocationScreenState extends State<ShareLocationScreen> {
   LatLng _initialPosition;

  Future <String> _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
              return Center(
                  child: Container(
                    child: Material(
                      color: Colors.red,
                      child: InkWell(
                        onTap: (){
                          String location;
                          _getUserLocation().then((value) => {
                          setState(() {
                          location = _initialPosition.toString();
                          Share.share("https://www.google.com/maps/search/?api=1&query=${_initialPosition.latitude},${_initialPosition.longitude}");
                          }
                          )
                          });
                        },
                        child: Text('Share location'),
                      ),
                    ),

              )
              );

            }



  }
