import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/products_provider.dart';
import 'package:shopApp/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.00),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ProductItem(products[index]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
