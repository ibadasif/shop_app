import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';
import '../provider/orders.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR ORDERS'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemBuilder: (ctx, i) => OrderItems(ordersData.orders[i]),
              itemCount: ordersData.orders.length,
            ),
    );
  }
}
