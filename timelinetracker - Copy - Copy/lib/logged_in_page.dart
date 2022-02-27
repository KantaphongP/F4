import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timelinetracker/api/google_signin_api.dart';
import 'package:timelinetracker/detail.dart';
import 'package:timelinetracker/map.dart';
import 'package:timelinetracker/seelocation.dart';
import 'main.dart';

//import 'package:http/http.dart' as http;

class LoggedInPage extends StatelessWidget {
  final GoogleSignInAccount user;

  const LoggedInPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Logged In',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text('Log Out'),
            onPressed: () async {
              await GoogleSignInApi.logout();

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MyApp(),
              ));
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoUrl!),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Name: ' + user.displayName!,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Email: ' + user.email,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const detail(
                              location: null,
                            )));
              },
              label: Text('See location'),
              icon: Icon(Icons.web),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MapsPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.near_me),
      ),
    );
  }
}

Locations locationsFromJson(String str) => Locations.fromJson(json.decode(str));

String locationsToJson(Locations data) => json.encode(data.toJson());

class Locations {
  Locations({
    required this.idLocation,
    required this.latitude,
    required this.longtitude,
  });

  String idLocation;
  String latitude;
  String longtitude;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        idLocation: json["idLocation"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
      );

  Map<String, dynamic> toJson() => {
        "idLocation": idLocation,
        "latitude": latitude,
        "longtitude": longtitude,
      };
}

class Env {
  static String URL_PREFIX = "https://timelinetracker.000webhostapp.com/";
}
