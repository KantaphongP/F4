import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class seeLocation extends StatefulWidget {
  const seeLocation({Key? key}) : super(key: key);

  @override
  _seeLocationState createState() => _seeLocationState();
}

getMethod() async {
  Uri theUrl = "https://timelinetracker.000webhostapp.com/getData.php" as Uri;
  var res = await http.get(theUrl, headers: {"Accept:": "application/json"});
  var responsbody = json.decode(res.body);
  //print(responsbody);
  return responsbody;
}

class _seeLocationState extends State<seeLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("connect php"),
      ),
      body: FutureBuilder(
          future: getMethod(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List snap = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error fetching Data"),
              );
            }
            return ListView.builder(
              itemCount: snap.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("data"),
                  subtitle: Text("data"),
                );
              },
            );
          }),
    );
  }
}
