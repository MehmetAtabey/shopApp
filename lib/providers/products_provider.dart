import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopApp/models/http_exception.dart';
import 'package:shopApp/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final String userId;
  ProductsProvider(this.userId);

  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return _items;
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
        filterbyUser ? '?orderBy="creatorId"&equalTo="$userId"' : null;
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
