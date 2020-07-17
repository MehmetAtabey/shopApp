import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product.dart';
import 'package:shopApp/providers/products_provider.dart';
import 'package:shopApp/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductsProvider>(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: product.id)),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => productProvider.deleteProduct(product.id)),
          ],
        ),
      ),
    );
  }
}
