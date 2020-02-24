import 'package:epasal/provider/cart_provider.dart';
import 'package:epasal/provider/order_provider.dart';
import 'package:epasal/provider/products_provider.dart';
import 'package:epasal/screens/cart_screen.dart';
import 'package:epasal/screens/order_screen.dart';
import 'package:epasal/screens/product_details_screen.dart';
import 'package:epasal/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "E-Pasal",
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.red,
            fontFamily: "Oswald"),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetails.routeId: (context) => ProductDetails(),
          CartScreen.routeId: (context) => CartScreen(),
          OrderScreen.routeId: (context) => OrderScreen(),
        },
      ),
    );
  }
}
