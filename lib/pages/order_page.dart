import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/app_drawer.dart';
import 'package:shop_flutter_app/models/order_list.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Meus pedidos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: orderList.items
            .map(
              (e) => Text(
                e.products.toString(),
              ),
            )
            .toList(),
      ),
    );
  }
}
