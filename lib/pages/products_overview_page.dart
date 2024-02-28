import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/product_grid.dart';
import 'package:shop_flutter_app/models/cart.dart';

enum FavoriteOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text(
          'Magazine Pegação',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FavoriteOptions.favorite,
                child: Text('Favoritos'),
              ),
              const PopupMenuItem(
                value: FavoriteOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FavoriteOptions favoriteOptions) {
              setState(() {
                _showFavoriteOnly = favoriteOptions == FavoriteOptions.favorite;
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, cart, child) => Badge(
              label: Text(cart.itemsCount.toString()),
              alignment: Alignment.topCenter,
              largeSize: 15,
              offset: const Offset(7, 4),
              child: child,
            ),
          )
        ],
      ),
      body: ProductGrid(
        showFavoriteOnly: _showFavoriteOnly,
      ),
    );
  }
}
