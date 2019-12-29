### Lesson 1 : Counter App

## Important Section
1. Import BLoC Fundamental
```dart
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
```

2. Make Counter Event
```dart
enum CounterEvent { increment, decrement }
```

3. Make BLoC Logic class that extends Bloc class
```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  ...
}
```

4. In CounterBloc class add required Bloc attributes and methods
```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  // initialState (fixed variable name !!!)
  @override
  int get initialState => 0;
  
  // mapEventToState (Make operate decision)
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
```

5. Make CounterPage class that is UI Widget (no logic)
```dart
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ...
  }
}
```

6. Declared BLoC Provider to connect with BLoC Logic (BlocCounter class) in UI Class
```dart
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  }
}
```

7. Triggle Action by
```dart
/ When want to increse counter number
counterBloc.add(CounterEvent.increment);

// When want to decrease counter number
counterBloc.add(CounterEvent.decrement);
```

8. main class (MyApp) Provider UI Widget (BlocPage with BlocProvider)
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}
```
