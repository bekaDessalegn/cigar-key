import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  String _test = "";
  String get myTest => _test;

  set test(String newtest) {
    _test = newtest;
    notifyListeners();
  }

  int _index = 0;
  int get myIndex => _index;

  set index(int newindex) {
    _index = newindex;
    notifyListeners();
  }

  bool _similar = false;
  bool get mySimilar => _similar;

  set similar(bool newsimilar) {
    _similar = newsimilar;
    notifyListeners();
  }

  bool _back = false;
  bool get myBack => _back;

  set back(bool back) {
    _back = back;
    notifyListeners();
  }

  bool _humidor = false;
  bool get myHumidor => _humidor;

  set humidor(bool newsimilar) {
    _humidor = newsimilar;
    notifyListeners();
  }

  bool _lounge = false;
  bool get myLounge => _lounge;

  set lounge(bool newlounge) {
    _lounge = newlounge;
    notifyListeners();
  }

  bool _checkHumidor = false;
  bool get myCeckHumidor => _checkHumidor;

  set checkHumidor(bool newcheckHumidor) {
    _checkHumidor = newcheckHumidor;
    notifyListeners();
  }

  String _coffeeValue = '';
  String get myCoffeeValue => _coffeeValue;

  set coffeeValue(String newValue) {
    _coffeeValue = newValue;
    notifyListeners();
  }

  String _natureValue = '';
  String get myNatureValue => _natureValue;

  set natureValue(String newValue) {
    _natureValue = newValue;
    notifyListeners();
  }

  String _sweetValue = '';
  String get mySweetValue => _sweetValue;

  set sweetValue(String newValue) {
    _sweetValue = newValue;
    notifyListeners();
  }

  String _herbValue = '';
  String get myHerbValue => _herbValue;

  set herbValue(String newValue) {
    _herbValue = newValue;
    notifyListeners();
  }

  String _fruitValue = '';
  String get myFruitValue => _fruitValue;

  set fruitValue(String newValue) {
    _fruitValue = newValue;
    notifyListeners();
  }
}
