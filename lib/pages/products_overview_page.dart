import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/product_item.dart';
import 'package:shop_flutter_app/models/product.dart';
import 'package:shop_flutter_app/models/product_list.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductList productProvider = Provider.of<ProductList>(context);
    List<Product> loadedProducts = productProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length, // amount item to render
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // two products peer line
          childAspectRatio: 3 / 2, // 1.5
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ProductItem(
          product: loadedProducts[index],
        ),
      ),
    );
  }
}
