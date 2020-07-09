import 'package:flutter/material.dart';
import 'package:shopApp/providers/order_provider.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(order.amount.toString()),
              subtitle: Text(order.dateTime.toString()),
              trailing:
                  IconButton(icon: Icon(Icons.expand_more), onPressed: null),
            )
          ],
        ));
  }
}
