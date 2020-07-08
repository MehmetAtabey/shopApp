import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/products_provider.dart';
import 'package:shopApp/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showfavs;

  ProductsGrid(this.showfavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context, listen: true);
    final products =
        showfavs ? productsData.favoritesItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.00),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: products[index], child: ProductItem()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
