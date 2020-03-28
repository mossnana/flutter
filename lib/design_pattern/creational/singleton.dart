import 'package:flutter/material.dart';

// Instance Prototype
abstract class SingletonStateBase {
  @protected
  String initialText;

  @protected
  String _stateText;
  String get currentText => _stateText;

  void setStateText(String text) {
    _stateText = text;
  }

  void resetState() {
    _stateText = initialText;
  }
}

// Manual Singleton Implemented Class
class SingletonStateInstance extends SingletonStateBase {
  static SingletonStateInstance _instance;

  // Factory Constructor
  SingletonStateInstance._internal() {
    initialText = 'Initial Text in SingletonStateInstance';
    _stateText = initialText;
  }

  static SingletonStateInstance getState() {
    // If a instance have created yet.
    if(_instance == null) {
      _instance = SingletonStateInstance._internal();
    }
    // If a instance already have created.
    return _instance;
  }
}

// Dart Default Singleton Implemented Class
class DefaultSingletonStateInstance extends SingletonStateBase {
  static final DefaultSingletonStateInstance _instance = DefaultSingletonStateInstance._internal();

  factory DefaultSingletonStateInstance() {
    return _instance;
  }

  DefaultSingletonStateInstance._internal() {
    initialText = 'Initial Text in DefaultSingletonStateInstance';
    _stateText = initialText;
  }
}

// Simple Class
class NonSingletonStateInstance extends SingletonStateBase {
  // Constructor
  NonSingletonStateInstance() {
    initialText = 'Initial Text in NonSingletonStateInstance';
    _stateText = initialText;
  }
}