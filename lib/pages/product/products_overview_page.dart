import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/app_drawer.dart';
import 'package:shop_flutter_app/components/center_message.dart';
import 'package:shop_flutter_app/components/circular_progress_message.dart';
import 'package:shop_flutter_app/components/product_grid.dart';
import 'package:shop_flutter_app/models/cart.dart';
import 'package:shop_flutter_app/models/product.dart';
import 'package:shop_flutter_app/providers/product_list.dart';
import 'package:shop_flutter_app/routes.dart';

enum FavoriteOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    _loadProducts();
  }

  void _loadProducts() {
    final provider = Provider.of<ProductList>(context, listen: false);
    provider.loadProducts().then((isLoaded) {
      if (!isLoaded) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Não foi possível carregar os produtos. Tente novamente mais tarde!'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        setState(() {
          products =
              _showFavoriteOnly ? provider.favoriteItems : provider.items;
        });
      }
      setState(() {
        _isLoading = false;
      });
    }).catchError((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = const Center(
      child: CircularProgressMessage('Carregando os produtos, aguarde.'),
    );

    if (products.isEmpty) {
      body = const CenterMessage('Nenhum produto listado');
    } else if (!_isLoading) {
      body = ProductGrid(
        products: products,
      );
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
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
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.cart);
              },
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
      body: body,
    );
  }
}
