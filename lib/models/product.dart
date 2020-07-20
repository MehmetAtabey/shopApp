import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite(String userId) async {
    isFavorite = !isFavorite;

    final url =
        'https://flutter-test-4f64b.firebaseio.com/userFavorites/$userId/$id.json';
    try {
      final response = await http.put(url, body: json.encode(isFavorite));
    } catch (e) {}
    notifyListeners();
  }
}
