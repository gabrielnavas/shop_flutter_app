import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter_app/data/products_dummy.dart';
import 'package:shop_flutter_app/models/product.dart';

class ProductList with ChangeNotifier {
  final String _url =
      "https://shop-flutter-app-ca225-default-rtdb.firebaseio.com";

  final List<Product> _items = productsDummy;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<bool> addProduct(Product product) async {
    // https://upload.wikimedia.org/wikipedia/pt/a/aa/Bart_Simpson_200px.png
    final resp = await http.post(
      Uri.parse('$_url/products.json'),
      body: jsonEncode({
        "id": product.id,
        "name": product.name,
        "description": product.description,
        "isFavorite": product.isFavorite,
        "price": product.price,
        "imageUrl": product.imageUrl,
      }),
    );
    _items.add(product);
    notifyListeners();
    return resp.statusCode == 200;
  }

  void updateProduct(Product product) {
    final int index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    final int index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}
