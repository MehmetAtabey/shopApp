import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String price;
  final String id;
  final String productId;

  CartItem(this.price,this.id,this.productId);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context,listen: false);
    return Dismissible(
      onDismissed:(direction) => cart.removeItem(productId),
      direction: DismissDirection.endToStart,
      key: ValueKey(id),    
      background: Container(color:Theme.of(context).errorColor,child: Icon(Icons.delete,color: Colors.white),alignment: Alignment.centerRight,padding: EdgeInsets.only(right: 20),),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(price),
                  )),
                ),
              ))),
    );
  }
}