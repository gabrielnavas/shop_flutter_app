import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/models/product_list.dart';
import 'package:shop_flutter_app/pages/product_detail_page.dart';
import 'package:shop_flutter_app/pages/products_overview_page.dart';
import 'package:shop_flutter_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'shop app flutter',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Lato',
        ),
        routes: {
          Routes.productDetail: (_) => const ProductDetailPage(),
        },
        home: const ProductsOverviewPage(),
      ),
    );
  }
}
