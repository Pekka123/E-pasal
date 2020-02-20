import 'package:cached_network_image/cached_network_image.dart';
import 'package:epasal/provider/cart_provider.dart';
import 'package:epasal/provider/product.dart';
import 'package:epasal/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    print("Build Created");
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetails.routeId,
                  arguments: product.id);
            },
            child: CachedNetworkImage(
              imageUrl: product.imageURL,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(
              builder: (ctx, prod, child) => IconButton(
                icon: prod.isFavourite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  prod.toggleIsFavourite();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addToCart(product.id, product.title, product.price);
              },
              color: Theme.of(context).accentColor,
            ),
          )),
    );
  }
}
