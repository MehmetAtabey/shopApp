import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/cart.dart';
import 'package:shopApp/providers/products_provider.dart';
import 'package:shopApp/screens/cart_screen.dart';
import 'package:shopApp/widgets/app_drawer.dart';
import 'package:shopApp/widgets/badge.dart';
import 'package:shopApp/widgets/products_grid.dart';

enum Filteroptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _loader = true;

  @override
  void initState() {
        Provider.of<ProductsProvider>(context,listen: false).fetchAndSetProducts().then((value) {
      setState(() {
        _loader = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("MyShop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (Filteroptions selectedvalue) {
              setState(() {
                if (selectedvalue == Filteroptions.Favorites)
                  _showOnlyFavorites = true;
                else
                  _showOnlyFavorites = false;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: Filteroptions.Favorites),
              PopupMenuItem(child: Text("Show All"), value: Filteroptions.All)
            ],
          ),
          Consumer<Cart>(
              builder: (_, cartData, child) => Badge(
                  child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(CartScreen.routeName)),
                  value: cartData.itemCount.toString()))
        ],
      ),
      body: _loader
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
