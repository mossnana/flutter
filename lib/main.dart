import 'package:flutter/material.dart';
import './screens/todo.dart' as home;
import './screens/add.dart' as add;

Widget homeRoute() {
  return home.Home();
}

Widget addRoute() {
  return add.Add();
}

void main() => runApp(
  MaterialApp(
    title: "Todo App",
    initialRoute: '/',
    routes: {
      '/': (context) => homeRoute(),
      '/add': (context) => addRoute(),
    },
  )
);
