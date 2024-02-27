import 'package:flutter/material.dart';
import 'package:shop_flutter_app/models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  List<Product> loadedProducts = Product.generateProducts();

  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: loadedProducts.length, // amount item to render
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // two products peer line
          childAspectRatio: 3 / 2, // 1.5
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => Text(loadedProducts[index].title),
      ),
    );
  }
}
