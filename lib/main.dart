import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/products_provider.dart';
import 'package:shopApp/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductsOverviewScreen(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop App"),
        ),
        body: Text(
            "test") // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
