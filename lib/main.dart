import 'package:designpattern/screens/adapter.dart';
import 'package:designpattern/screens/singleton.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Pattern',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 20
          ),
          display1: TextStyle(
              fontSize: 15
          ),
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Design Pattern'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('Creational Pattern', style: textTheme.title,),
              ),
            ),
            ListTile(
              title: Text('Singleton'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SingletonScreen()
                    )
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('Structural Pattern', style: textTheme.title,),
              ),
            ),
            ListTile(
              title: Text('Adapter'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => AdapterScreen()
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
