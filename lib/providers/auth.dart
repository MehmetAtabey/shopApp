import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signup(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAr1gmSanpyHzPbAWrSROchs2qanpjnYDo";

    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    print(json.decode(response.body));
    _token = json.decode(response.body)['idToken'];
    _userId = json.decode(response.body)['localId'];
    _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(json.decode(response.body)['expiresIn'])));
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAr1gmSanpyHzPbAWrSROchs2qanpjnYDo";

    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    print(json.decode(response.body));
    _token = json.decode(response.body)['idToken'];
    _userId = json.decode(response.body)['localId'];
    _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(json.decode(response.body)['expiresIn'])));
    autoLogOut();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': userId,
      'expiryDate': _expiryDate.toIso8601String()
    });
    prefs.setString('userDate', userData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;
    final exractedUSerData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(exractedUSerData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return false;

    final token = DateTime.parse(exractedUSerData['token']);
    final userid = DateTime.parse(exractedUSerData['userId']);
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void autoLogOut() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: 100), logout);
  }
}
