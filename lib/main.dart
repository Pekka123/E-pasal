import 'package:epasal/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "E-Pasal",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProductOverViewScreen(),
    );
  }
}
