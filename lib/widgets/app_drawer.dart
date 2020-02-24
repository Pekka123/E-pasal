import 'package:epasal/screens/order_screen.dart';
import 'package:epasal/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Sushan Manandhar'),
            accountEmail: Text('manandharsushan85@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/sushan.JPG'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('shop'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ProductOverViewScreen.routeId);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routeId);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
