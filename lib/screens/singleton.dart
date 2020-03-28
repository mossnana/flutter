import 'package:designpattern/design_pattern/creational/singleton.dart';
import 'package:flutter/material.dart';

class SingletonScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SingletonScreen();
  }
}

class _SingletonScreen extends State<SingletonScreen> {

  final List<SingletonStateBase> stateList = [
    // Manual Singleton Implemented Class
    SingletonStateInstance.getState(),
    // Dart Default Singleton Implemented Class
    DefaultSingletonStateInstance(),
    // Simple Class
    NonSingletonStateInstance()
  ];

  void _setTextState([String text = 'Singleton']) {
    stateList.forEach((state) {
      state.setStateText(text);
    });
    setState(() {});
  }

  void _reset() {
    stateList.forEach((state) {
      state.resetState();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Singleton'),
        actions: <Widget>[
          FlatButton(
            color: Colors.green,
            child: Text('Change'),
            onPressed: _setTextState,
          ),
          FlatButton(
            color: Colors.red,
            child: Text('Reset'),
            onPressed: _reset,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Manual Singleton', style: textTheme.title,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(stateList[0].currentText, style: textTheme.display1,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Auto Singleton by Dart', style: textTheme.title,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(stateList[1].currentText, style: textTheme.display1,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text('Non Singleton', style: textTheme.title,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(stateList[2].currentText, style: textTheme.display1,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}