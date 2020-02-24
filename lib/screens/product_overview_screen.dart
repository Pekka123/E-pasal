import 'package:epasal/provider/cart_provider.dart';
import 'package:epasal/screens/cart_screen.dart';
import 'package:epasal/widgets/app_drawer.dart';
import 'package:epasal/widgets/badge.dart';
import 'package:epasal/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorites, All }

class ProductOverViewScreen extends StatefulWidget {
  static const String routeId = "/product_overview_screen";

  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-pasal"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavourites = true;
                } else {
                  _showFavourites = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text("Show Favorites"),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text("Show all"),
              )
            ],
          ),
          Consumer<Cart>(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeId);
                },
              ),
              builder: (_, cart, child) {
                return Badge(
                  child: child,
                  value: cart.itemCount.toString(),
                );
              })
        ],
      ),
      body: ProductGrid(_showFavourites),
      drawer: AppDrawer(),
    );
  }
}
