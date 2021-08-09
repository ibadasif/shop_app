import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';
import '../provider/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR ORDERS'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItems(ordersData.orders[i]),
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
