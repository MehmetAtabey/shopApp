import 'package:flutter/material.dart';
import 'package:shopApp/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Image.network(product.imageUrl, fit: BoxFit.cover),
        footer: GridTileBar(
          leading: IconButton(icon: Icon(Icons.favorite), onPressed: null),
          trailing:
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: null),
          title: Text(product.title),
          backgroundColor: Colors.black54,
        ));
  }
}
