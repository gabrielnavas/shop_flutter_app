import 'package:flutter/material.dart';
import 'package:shop_flutter_app/models/cart.dart';
import 'package:shop_flutter_app/models/order.dart';
import 'package:uuid/uuid.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get orderCount => _items.length;

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: const Uuid().v4(),
        total: cart.totalAmout,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
