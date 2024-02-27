import 'package:flutter/material.dart';
import 'package:shop_flutter_app/pages/counter_page.dart';
import 'package:shop_flutter_app/pages/products_overview_page.dart';
import 'package:shop_flutter_app/providers/counter.dart';
import 'package:shop_flutter_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'shop app flutter',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Lato',
        ),
        routes: {
          Routes.productDetail: (_) => const CounterPage(),
        },
        home: ProductsOverviewPage(),
      ),
    );
  }
}
