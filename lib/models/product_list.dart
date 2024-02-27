import 'package:flutter/material.dart';
import 'package:shop_flutter_app/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = Product.generateProducts();

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
