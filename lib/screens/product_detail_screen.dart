import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product.dart';
import 'package:shopApp/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String routeName = "/product-detail";
  Product product;
  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    product = Provider.of<ProductsProvider>(context).findById(productId);

    return Scaffold(
        appBar: AppBar(title: Text(product.title)), body: Text("test"));
  }
}
