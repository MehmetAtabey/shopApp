import 'package:flutter/material.dart';
import 'package:shopApp/models/product.dart';
import 'package:shopApp/screens/edit_product_screen.dart';
import 'package:shopApp/screens/product_detail_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
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
            IconButton(icon: Icon(Icons.delete), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
