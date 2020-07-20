import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopApp/models/http_exception.dart';
import 'package:shopApp/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final String userId;
  List<Product> _items = [];


    ProductsProvider(this.userId,this._items);


List<Product> get items {

    return [..._items];
  }

  // Future<void> addProduct(Product product) {
  //   const url = 'https://flutter-test-4f64b.firebaseio.com/products.json';
  //   return http
  //       .post(url,
  //           body: json.encode({
  //             'title': product.title,
  //             'description:': product.description,
  //             'imageUrl': product.imageUrl,
  //             'price': product.price,
  //             'isFavorite': product.isFavorite,
  //             'gulperi': 'test'
  //           }))
  //       .then((response) {
  //     print(json.decode(response.body));
  //     items.add(new Product(
  //         id: json.decode(response.body)['name'],
  //         title: product.title,
  //         description: product.description,
  //         price: product.price,
  //         imageUrl: product.imageUrl));
  //     notifyListeners();
  //   }).catchError((error) {
  //     print(error);
  //     throw error;
  //   });
  // }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-test-4f64b.firebaseio.com/products.json';

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId
          }));
      items.add(new Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl));
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchAndSetProducts([bool filterbyUser = false]) async {
    final filterString =
        filterbyUser ? '?orderBy="creatorId"&equalTo="$userId"' : "";
    final url =
        'https://flutter-test-4f64b.firebaseio.com/products.json$filterString';
    try {
      final response = await http.get(url);
      final exractedData = json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      final favoriteResponse = await http.get(
          'https://flutter-test-4f64b.firebaseio.com/userFavorites/$userId.json');
      final favoriteData = json.decode(favoriteResponse.body);
      _items = [];
      exractedData.forEach((key, value) {
        _items.add(new Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[key] ?? false,
            imageUrl: value['imageUrl']));
      });
      notifyListeners();
    } catch (ex) {
      throw ex;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final producIndex = items.indexWhere((element) => element.id == id);
    if (producIndex >= 0) {
      final url = 'https://flutter-test-4f64b.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[producIndex] = newProduct;
      notifyListeners();
    } else
      print('...');
  }

  Future<void> deleteProduct(String id) async {
    try {
      final url = 'https://flutter-test-4f64b.firebaseio.com/products/$id.json';
      await http
          .delete(url)
          .catchError((_) => throw HttpException('could not delete'))
          .then((value) => _items.removeWhere((element) => element.id == id));

      notifyListeners();
    } catch (ex) {
      throw ex;
    }
  }

  List<Product> get favoritesItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
