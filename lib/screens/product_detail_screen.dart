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
        appBar: AppBar(title: Text(product.title)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 10),
              Text(product.price.toString() + " TRY",
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
              SizedBox(height: 10),
              Text(
                product.description.toString(),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ],
          ),
        ));
  }
}
