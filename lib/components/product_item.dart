import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/models/product.dart';
import 'package:shop_flutter_app/routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    // not change UI (performatic)
    final Product product = Provider.of<Product>(context);

    // grid with rows and columns
    Widget gridTileProduct = GridTile(
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
          icon:
              Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
          onPressed: () {
            product.toggleFavorite();
          },
          color: Colors.redAccent,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
          color: const Color.fromARGB(204, 255, 234, 0),
        ),
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          Routes.productDetail,
          arguments: product,
        ),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );

    // clip an element, on border this case
    Widget clipRRect = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: gridTileProduct,
    );
    return clipRRect;
  }
}
