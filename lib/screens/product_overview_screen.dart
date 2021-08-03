import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ProductsGrid(),
    );
  }
}
