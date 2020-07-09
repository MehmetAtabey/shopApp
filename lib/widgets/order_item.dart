import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopApp/providers/order_provider.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(widget.order.amount.toString()),
              subtitle: Text(widget.order.dateTime.toString()),
              trailing: IconButton(
                  icon: Icon(Icons.expand_more),
                  onPressed: () =>setState((){_expanded = !_expanded;}) ),
            ),
            if (_expanded)
              Container(
                height: min(widget.order.products.length * 20.0 + 100, 180),
                child: ListView(children: widget.order.products.map((e) => Row(children: <Widget>[
                  Text(e.title),
                  Text(e.quantity.toString()),
                ],)).toList(),)
              )
          ],
        ));
  }
}
