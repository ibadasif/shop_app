import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItems({
    this.id,
    this.price,
    this.quantity,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                  child: Text(
                'Rs ${price}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: Rs ${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
