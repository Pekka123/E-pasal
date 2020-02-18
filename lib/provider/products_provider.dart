import 'file:///C:/Users/him/AndroidStudioProjects/epasal/lib/provider/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: "first",
        title: "Watch",
        price: 30000,
        description: "the best watch you will find anywherehere",
        imageURL:
            "https://www.pricerunner.com/product/1200x630/1907050850/Apple-Watch-Series-5-Cellular-44mm-Aluminum-Case-with-Sport-Band.jpg",
        isFavourite: false),
    Product(
        id: "first",
        title: "Shoes",
        price: 9000,
        description: "QUALITY AND COMFORT SHOES",
        imageURL:
            "https://www.pablogiftshop.com/wp-content/uploads/2019/08/92c7e501-22ed-4ce1-9e62-b3343361b9fc.jpg",
        isFavourite: false),
    Product(
        id: "first",
        title: "Laptop",
        price: 400000,
        description: "BEST GAMING LAPTOP HERE",
        imageURL: "https://prod.scorptec.com.au/21/613/78203/183587_large.jpg",
        isFavourite: false),
    Product(
        id: "first",
        title: "OnePLus 7t",
        price: 67000,
        description: "BEST AVERAGE PHONE ",
        imageURL: "https://fdn2.gsmarena.com/vv/bigpic/oneplus-7t-.jpg",
        isFavourite: false),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return items.firstWhere((prod) {
      return prod.id == id;
    });
  }

  void addProduct() {
    _items.add(
      Product(
          id: "first",
          title: "OnePLus 8",
          price: 88000,
          description: "BEST PHONE ",
          imageURL:
              "https://i.gadgets360cdn.com/large/OnePlus_8_Render_Cashkaro_1570177447327.jpg",
          isFavourite: false),
    );
    notifyListeners();
  }
}
