import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter_app/models/product.dart';

class ProductList with ChangeNotifier {
  final String _url =
      "https://shop-flutter-app-ca225-default-rtdb.firebaseio.com/products.json";

  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<bool> addProduct(Product product) async {
    // https://upload.wikimedia.org/wikipedia/pt/a/aa/Bart_Simpson_200px.png
    try {
      final resp = await http.post(
        Uri.parse(_url),
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
      return resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> loadProducts() async {
    try {
      final resp = await http.get(
        Uri.parse(_url),
      );
      dynamic body = jsonDecode(resp.body);
      if (body is Map<String, dynamic>) {
        body.forEach((_, productData) {
          int indexFound = _items.indexWhere(
              (element) => element.id == productData["id"] as String);
          if (indexFound == -1) {
            _items.add(
              Product(
                id: productData['id'] as String,
                name: productData['name'] as String,
                description: productData['description'] as String,
                price: productData['price'] as double,
                imageUrl: productData['imageUrl'] as String,
              ),
            );
          }
        });
      } else if (body == null) {
        // when the products is empty, firebase returns null on body
        return true;
      }
      return true;
    } catch (ex) {
      return false;
    }
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
