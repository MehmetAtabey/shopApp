import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
    notifyListeners();
  }
}
