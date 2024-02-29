import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/product_grid_item.dart';
import 'package:shop_flutter_app/models/product.dart';
import 'package:shop_flutter_app/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid({
    required this.showFavoriteOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    if (loadedProducts.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum produto listado',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length, // amount item to render
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // two products peer line
        childAspectRatio: 3 / 2, // 1.5
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: const ProductGridItem(),
      ),
    );
  }
}
