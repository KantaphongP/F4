import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'logged_in_page.dart';

class detail extends StatefulWidget {
  const detail({Key? key, required location}) : super(key: key);

  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  late Future<List<Locations>> location;
  final locationListKey = GlobalKey<_detailState>();

  @override
  void initState() {
    super.initState();
    location = getLocationList();
    print("2");
    //print(location.runtimeType);
    //print(location);
  }

  /*getMethod() async {
    //Uri theUrl = "https://timelinetracker.000webhostapp.com/getData.php" as Uri;
    //var res = await http.get(theUrl, headers: {"Accept:": "application/json"});
    final res = await http.get(Uri.parse('${Env.URL_PREFIX}/get.php'));
    var responsbody = json.decode(res.body);
    print(responsbody);
    return responsbody;
  }*/

  Future<List<Locations>> getLocationList() async {
    final response = await http.get(Uri.parse('${Env.URL_PREFIX}/get.php'));

    //late Future<List<Locations>> items;
    final items = json.decode(response.body);

    //location=items.map<Locations>((json) => Locations.fromJson(json)).toList();
    // final locationslist =await items.map<Locations>((json){
    //   return Locations.fromJson(json);

    // }).toList();
    print("1");
    //return items.map((json) => Locations.fromJson(json)).toList();

    print(items.runtimeType);
    print(items);
    return items;
  }

  /*@override
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
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: locationListKey,
      appBar: AppBar(
        title: Text('Location List'),
      ),
      body: Center(
        child: FutureBuilder<List<Locations>>(
          future: location,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();
            // Render student lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.name,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => detail(location: data)),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (_) {
      //       return Create();
      //     }));
      //   },
      // ),
    );
  }
}
