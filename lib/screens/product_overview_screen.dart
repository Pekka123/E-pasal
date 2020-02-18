import 'file:///C:/Users/him/AndroidStudioProjects/epasal/lib/provider/product.dart';
import 'package:epasal/provider/products_provider.dart';
import 'package:epasal/widgets/product_grid.dart';
import 'package:epasal/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOverViewScreen extends StatelessWidget {
  static const String routeId = "/product_overview_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-pasal"),
      ),
      body: ProductGrid(),
    );
  }
}
