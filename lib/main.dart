import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/models/cart.dart';
import 'package:shop_flutter_app/pages/product/products_manager_page.dart';
import 'package:shop_flutter_app/providers/order_list.dart';
import 'package:shop_flutter_app/providers/product_list.dart';
import 'package:shop_flutter_app/pages/cart/cart_page.dart';
import 'package:shop_flutter_app/pages/order/order_page.dart';
import 'package:shop_flutter_app/pages/product/product_detail_page.dart';
import 'package:shop_flutter_app/pages/product/product_form_page.dart';
import 'package:shop_flutter_app/pages/product/products_overview_page.dart';
import 'package:shop_flutter_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'shop app flutter',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Lato',
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (_) => const ProductsOverviewPage(),
          Routes.productDetail: (_) => const ProductDetailPage(),
          Routes.cart: (_) => const CartPage(),
          Routes.order: (_) => const OrderPage(),
          Routes.products: (_) => const ProductsManager(),
          Routes.productForm: (_) => const ProductFormPage(),
        },
      ),
    );
  }
}
