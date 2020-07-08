import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/cart.dart';
import 'package:shopApp/widgets/cart_item.dart' as caritemwidget;

class CartScreen extends StatelessWidget {
static final String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(appBar: AppBar(title: Text("Your Cart")),body: Column(children: <Widget>[
      Card(margin: EdgeInsets.all(15),child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
          Text("Total",style: TextStyle(fontSize: 20)),
          SizedBox(width: 10),
          Spacer(),
          Chip(label: Text(cart.totalAmount.toString(),style:TextStyle(color: Theme.of(context).primaryTextTheme.headline6.color),),backgroundColor: Theme.of(context).primaryColor),
          FlatButton(onPressed: (){}, child: Text("Order Now"))
        ]),
      ),),
      SizedBox(height: 10),
      Expanded(child: ListView.builder(itemBuilder: (context, index) => caritemwidget.CartItem(cart.items.values.toList()[index].price.toString(),cart.items.values.toList()[index].id.toString(),cart.items.keys
      .toList()[index])
      ,itemCount: cart.items.length))
    ],),);
  }
}