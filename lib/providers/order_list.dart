import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_flutter_app/exceptions/http_exception.dart';
import 'package:shop_flutter_app/models/cart.dart';
import 'package:shop_flutter_app/models/order.dart';
import 'package:uuid/uuid.dart';

import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final String _url =
      "https://shop-flutter-app-ca225-default-rtdb.firebaseio.com/orders";

  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get orderCount => _items.length;

  Future<void> addOrder(Cart cart) async {
    Order order = Order(
      id: const Uuid().v4(),
      total: cart.totalAmout,
      cartItems: cart.items.values.toList(),
      date: DateTime.now(),
    );

    _items.insert(0, order);
    notifyListeners();

    final String orderJson = order.toJson();

    try {
      final resp = await http.post(
        Uri.parse(
          '$_url.json',
        ),
        body: orderJson,
      );

      if (resp.statusCode >= 400) {
        items.remove(order);
        notifyListeners();
        throw HttpException(
          message:
              'Não foi possível concluir a operação. Tente novamente mais tarde.',
          status: 400,
        );
      }

      final body = jsonDecode(resp.body);

      String orderIdFirebase = body['name'] as String;
      order.id = orderIdFirebase;
    } catch (ex) {
      items.remove(order);
      notifyListeners();
      throw HttpException(
        message:
            'Não foi possível concluir a operação. Tente novamente mais tarde.',
        status: 400,
      );
    }
  }
}
