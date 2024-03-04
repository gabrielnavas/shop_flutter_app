import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/app_drawer.dart';
import 'package:shop_flutter_app/components/center_message.dart';
import 'package:shop_flutter_app/components/circular_progress_message.dart';
import 'package:shop_flutter_app/components/product_item.dart';
import 'package:shop_flutter_app/models/product.dart';
import 'package:shop_flutter_app/providers/product_list.dart';
import 'package:shop_flutter_app/routes.dart';

class ProductsManager extends StatefulWidget {
  const ProductsManager({super.key});

  @override
  State<ProductsManager> createState() => _ProductsManagerState();
}

class _ProductsManagerState extends State<ProductsManager> {
  List<Product> loadedProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadProducts();
  }

  void _loadProducts() {
    final productListProvider =
        Provider.of<ProductList>(context, listen: false);

    productListProvider.loadProducts().then((isLoaded) {
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
          loadedProducts = productListProvider.items;
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

    if (loadedProducts.isEmpty) {
      body = const CenterMessage('Nenhum produto listado');
    } else if (!_isLoading) {
      body = Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: loadedProducts.length,
          itemBuilder: (context, index) => Column(
            children: [
              ProductItem(loadedProducts[index]),
              const Divider(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.productForm).then(
                      (product) => setState(
                        () => loadedProducts.add(product as Product),
                      ),
                    ),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: body,
    );
  }
}
