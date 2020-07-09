import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/order_provider.dart';
import 'package:shopApp/widgets/app_drawer.dart';
import 'package:shopApp/widgets/order_item.dart' as orderitemscreen;

class OrdersScreen extends StatelessWidget {
  static final routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context);
    print(orderProvider.orders.toString());
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(title: Text("My Orders")),
        body: ListView.builder(
            itemBuilder: (context, index) =>
                orderitemscreen.OrderItem(orderProvider.orders[index]),
            itemCount: orderProvider.orders.length));
  }
}
