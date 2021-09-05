import 'package:flutter/material.dart';
import './provider/auth.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './provider/orders.dart';
import './screens/cart_screen.dart';
import './provider/cart.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './provider/products.dart';
import 'package:provider/provider.dart';
import './screens/user_products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.grey,
          fontFamily: 'Lato',
        ),
        home: AuthScreen(), //ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          //AuthScreen.routeName: (ctx) => AuthCard(),
        },
      ),
    );
  }
}
