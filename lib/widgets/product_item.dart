import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/models/product.dart';
import 'package:shopApp/providers/auth.dart';
import 'package:shopApp/providers/cart.dart';
import 'package:shopApp/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: true);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return GridTile(
        child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id),
            child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        footer: GridTileBar(
          leading: IconButton(
              icon: Icon(product.isFavorite ? Icons.star : Icons.favorite),
              onPressed: () => product.toggleFavorite(auth.userId)),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Added Item to cart!!"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: "Undo",
                        onPressed: () => cart.removeItem(product.id))));
              }),
          title: Text(product.title),
          backgroundColor: Colors.black54,
        ));
  }
}
