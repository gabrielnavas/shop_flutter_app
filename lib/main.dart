import 'package:flutter/material.dart';
import 'package:shop_flutter_app/pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'shop app flutter',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewPage(),
    );
  }
}
