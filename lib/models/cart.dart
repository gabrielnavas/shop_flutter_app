import 'package:flutter/material.dart';
import 'package:shop_flutter_app/models/cart_item.dart';
import 'package:shop_flutter_app/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmout {
    double total = 0.00;

    for (MapEntry<String, CartItem> entry in _items.entries) {
      CartItem cartItem = entry.value;
      double priceProduct = cartItem.productPrice * cartItem.quantity;
      total = total + priceProduct;
    }

    return total;
  }

  void remove(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void add(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingProduct) => CartItem(
          id: existingProduct.id,
          quantity: existingProduct.quantity + 1,
          productId: existingProduct.id,
          productName: existingProduct.productName,
          productPrice: existingProduct.productPrice,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem.create(
          product.id,
          product.name,
          1,
          product.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
