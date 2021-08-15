import 'package:flutter/material.dart';
import 'package:shop_app/widgets/order_item.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url =
        'https://flutter-update-b7923-default-rtdb.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'datetime': timeStamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://flutter-update-b7923-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(url);
    final List<OrderItem> loadedorders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedorders.add(
        OrderItem(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (items) => CartItem(
                    id: items['id'],
                    title: items['title'],
                    quantity: items['quantity'],
                    price: items['price'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(
              orderData['datetime'],
            )),
      );
    });
    _orders = loadedorders.reversed.toList();
    notifyListeners();
  }
}
