import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/products_provider.dart';
import 'package:shopApp/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userproductitem';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.add), onPressed: () {})
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => UserProductItem(productsData.items[i]),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
