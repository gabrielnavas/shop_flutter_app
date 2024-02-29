import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/app_drawer.dart';
import 'package:shop_flutter_app/components/product_item.dart';
import 'package:shop_flutter_app/models/product_list.dart';

class ProducstPage extends StatelessWidget {
  const ProducstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList productList = Provider.of<ProductList>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productList.itemsCount,
            itemBuilder: (context, index) => Column(
                  children: [
                    ProductItem(productList.items[index]),
                    const Divider()
                  ],
                )),
      ),
    );
  }
}
