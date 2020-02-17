import 'package:epasal/provider/products_provider.dart';
import 'package:epasal/screens/product_details_screen.dart';
import 'package:epasal/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: "E-Pasal",
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.red,
            fontFamily: "Oswald"),
        home: ProductOverViewScreen(),
        routes: {
          ProductOverViewScreen.routeId: (context) => ProductOverViewScreen(),
          ProductDetails.routeId: (context) => ProductDetails(),
        },
      ),
    );
  }
}
