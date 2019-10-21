import 'package:flutter/material.dart';
import '../classes/profile.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Profile> fetch() async {
  print("Fetching Data");
  final response = await http.get('https://mossnana.azurewebsites.net', headers: {"Content-type": "application/json"});
  if (response.statusCode == 200) {
    Profile mappedData = Profile.toJson(json.decode(response.body));
    return mappedData;
  } else {
    throw Exception('Failed to load post');
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Future<Profile> profile;

  @override
  void initState() {
    super.initState();
    profile = fetch();
  }

  void _getUpdate() {
    setState(() {
     profile = fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new MaterialApp(
      title: "Basic Fetch Data from APIs",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello")
        ),
        body: Container(
          alignment: Alignment(0.0, 0.0),
          child: FutureBuilder<Profile>(
            future: profile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String img = snapshot.data.imageUrl;
                return Stack(
                  children: <Widget>[
                    Container(color: Colors.green[100]),
                    Container(
                      alignment: Alignment(0.0, 0.0),
                      padding: EdgeInsets.all(20),
                      child: Column(children: <Widget>[
                        CircleAvatar(radius:_width<_height? _width/4:_height/4,backgroundImage: NetworkImage(img),),
                        SizedBox(height: _height/25.0,),
                        Text('Firstname: ${snapshot.data.firstName}'),
                        Text('Lastname: ${snapshot.data.lastName}'),
                        Text('Email: ${snapshot.data.email}'),
                        RaisedButton(
                          child: Text("Update Info"),
                          onPressed: _getUpdate,
                        )
                      ],),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
