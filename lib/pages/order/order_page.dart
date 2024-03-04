import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter_app/components/app_drawer.dart';
import 'package:shop_flutter_app/components/order_widget.dart';
import 'package:shop_flutter_app/models/order.dart';
import 'package:shop_flutter_app/providers/order_list.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of<OrderList>(context);

    ListView orders = ListView.builder(
      itemCount: orderList.orderCount,
      itemBuilder: (context, index) => OrderWidget(orderList.items[index]),
    );

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Meus pedidos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: orderList.orderCount > 0
          ? orders
          : const Center(
              child: Text(
                'Nenhum pedido foi feito ainda!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black54,
                ),
              ),
            ),
    );
  }
}
