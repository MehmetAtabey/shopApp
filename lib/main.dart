import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/auth.dart';
import 'package:shopApp/providers/cart.dart';
import 'package:shopApp/providers/order_provider.dart';
import 'package:shopApp/providers/products_provider.dart';
import 'package:shopApp/screens/auth_screen.dart';
import 'package:shopApp/screens/cart_screen.dart';
import 'package:shopApp/screens/edit_product_screen.dart';
import 'package:shopApp/screens/orders_screen.dart';
import 'package:shopApp/screens/product_detail_screen.dart';
import 'package:shopApp/screens/products_overview_screen.dart';
import 'package:shopApp/screens/splash_screen.dart';
import 'package:shopApp/screens/users_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          // ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
              create: null,
              update: (context, value, previous) => ProductsProvider(
                  value.userId, previous == null ? [] : previous.items)),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => OrdersProvider()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'Shop App',
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato'),
              home: auth.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen()),
              routes: {
                ProductDetailScreen.routeName: (context) =>
                    ProductDetailScreen(),
                CartScreen.routeName: (context) => CartScreen(),
                OrdersScreen.routeName: (context) => OrdersScreen(),
                UserProductsScreen.routeName: (context) => UserProductsScreen(),
                EditProductScreen.routeName: (context) => EditProductScreen()
              }),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop App"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) => print(value),
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(child: Text("Only Favorites"), value: 0),
                PopupMenuItem(child: Text("Show All"), value: 1)
              ],
            )
          ],
        ),
        body: Text(
            "test") // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
