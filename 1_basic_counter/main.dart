import 'package:flutter/material.dart';
import 'dart:async';
// BLoC Patterns
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

// Counter Events
enum CounterEvent { increment, decrement }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterBloc extends Bloc<CounterEvent, int> {
  // Init State
  @override
  int get initialState => 0;
  // Map Action to State like Redux
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch(event) {
      case CounterEvent.increment:
        print('Before State Change state is $state');
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
        break;
    }
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // BLoC Provider
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Counter BLoC'),),
      body: BlocBuilder<CounterBloc, int> (
        builder: (context, count) {
          return Center(
              child: Text(
                '$count',
                style: TextStyle(fontSize: 24.0),
              )
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                // Pass BLoC Action to BLoC Provider that have add function
                counterBloc.add(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                // Pass BLoC Action to BLoC Provider that have add function
                counterBloc.add(CounterEvent.decrement);
              },
            ),
          ),
        ],
      ),
    );
  }
}
