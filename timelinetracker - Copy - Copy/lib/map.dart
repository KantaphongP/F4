import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import "package:geocoding/geocoding.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  // void _getLocation () async{
  //   LocationPermission permission = await Geolocator.requestPermission();
  //   Position position = await Geolocator.
  //   getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   //print(position);
  // }
  Position? _currentPosition;
  late String _currentAddress;
  GoogleMapController? mapController;

  void _onMapCreate(GoogleMapController controller) {
    mapController = controller;
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street},${place.subLocality},${place.locality},${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Position?> _getCurrentLocation() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position? position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
          _getAddressFromLatLng();
        });
      }
    }).catchError((e) {
      print(e);
    });
    return _currentPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: FutureBuilder(
        future: _getCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<Position?> snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreate,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(_currentPosition!.latitude.toDouble(),
                      _currentPosition!.longitude.toDouble()),
                  zoom: 15),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Your Location"),
                content: new Text(
                    "lat: ${_currentPosition?.latitude} long: ${_currentPosition?.longitude} \n $_currentAddress "),
                actions: <Widget>[
                  RaisedButton(
                    child: new Text("Check In"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          /*showDialog(
              context: context,
              builder: (context) {
                return  
                AlertDialog(
                  content: Text(
                      'Your location : \n lat: ${_currentPosition?.latitude} long: ${_currentPosition?.longitude} \n $_currentAddress '),
                );
              });*/
        },
        label: Text("Check In"),
        icon: Icon(Icons.near_me),
      ),
    );
  }
}
