import 'package:flutter/material.dart';
import 'package:shop_flutter_app/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    // grid with rows and columns
    Widget grid = GridTile(
      footer: GridTileBar(
        title: Text(
          product.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11.4,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(208, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {},
          color: Colors.redAccent,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
          color: Colors.yellowAccent.shade700,
        ),
      ),
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );

    // clip an element, on border this case
    Widget clipRRect = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: grid,
    );
    return clipRRect;
  }
}
