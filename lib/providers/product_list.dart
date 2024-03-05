import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter_app/exceptions/http_exception.dart';
import 'package:shop_flutter_app/models/product.dart';

class ProductList with ChangeNotifier {
  final String _url =
      "https://shop-flutter-app-ca225-default-rtdb.firebaseio.com/products";

  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<bool> addProduct(Product product) async {
    // https://upload.wikimedia.org/wikipedia/pt/a/aa/Bart_Simpson_200px.png
    // https://upload.wikimedia.org/wikipedia/en/c/c2/Peter_Griffin.png
    try {
      final resp = await http.post(
        Uri.parse(
          '$_url.json',
        ),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "isFavorite": product.isFavorite,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );
      final body = jsonDecode(resp.body);
      String productIdFirebase = body['name'] as String;
      product.id = productIdFirebase;
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
    _items.clear();

    try {
      final resp = await http.get(
        Uri.parse(
          '$_url.json',
        ),
      );
      dynamic body = jsonDecode(resp.body);
      if (body == null) {
        // when the products is empty, firebase returns null on body
        return true;
      }

      body.forEach((productId, productData) {
        _items.add(
          Product(
            id: productId,
            name: productData['name'] as String,
            description: productData['description'] as String,
            price: productData['price'] as double,
            imageUrl: productData['imageUrl'] as String,
            isFavorite: productData['isFavorite'] as bool,
          ),
        );
      });
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<void> removeFavoriteProduct(String productId) async {
    if (!await _toggleFavorite(productId)) {
      throw HttpException(
        message: 'Não foi possível favoritar. Tente novamente mais tarde',
        status: 400,
      );
    }
  }

  Future<void> turnFavoriteProduct(String productId) async {
    if (!await _toggleFavorite(productId)) {
      throw HttpException(
        message: 'Não foi possível favoritar. Tente novamente mais tarde',
        status: 400,
      );
    }
  }

  Future<bool> _toggleFavorite(String productId) async {
    final int index = _items.indexWhere((element) => element.id == productId);
    if (index >= 0) {
      _items[index].isFavorite = !_items[index].isFavorite;
      notifyListeners();

      final resp = await http.patch(
        Uri.parse(
          '$_url/$productId.json',
        ),
        body: jsonEncode({
          "isFavorite": _items[index].isFavorite,
        }),
      );
      if (resp.statusCode >= 400) {
        _items[index].isFavorite = !_items[index].isFavorite;
        notifyListeners();
        return false;
      } else {
        return true;
      }
    }

    return false;
  }

  Future<bool> updateProduct(Product product) async {
    final int index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '$_url/${product.id}.json',
        ),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );

      _items[index] = product;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> removeProduct(Product product) async {
    try {
      final int index =
          _items.indexWhere((element) => element.id == product.id);
      if (index >= 0) {
        _items.removeAt(index);
      } else {
        throw HttpException(
            message: 'Esse produto não existe mais', status: 404);
      }

      final resp = await http.delete(
        Uri.parse(
          '$_url/${product.id}.json',
        ),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );

      if (resp.statusCode >= 400) {
        addProduct(product);
        if (resp.statusCode == 404) {
          throw HttpException(
              message: 'Esse produto não existe mais', status: 404);
        } else {
          throw HttpException(
              message:
                  'Erro ao tentar remover o produto. Tente novamente mais tarde.',
              status: 404);
        }
      }
    } catch (ex) {
      throw HttpException(
          message:
              'Erro ao tentar remover o produto. Tente novamente mais tarde.',
          status: 404);
    } finally {
      notifyListeners();
    }
  }
}
