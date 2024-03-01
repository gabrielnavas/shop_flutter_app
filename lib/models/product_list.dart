import 'package:flutter/material.dart';
import 'package:shop_flutter_app/data/products_dummy.dart';
import 'package:shop_flutter_app/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = productsDummy;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final int index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }
}
