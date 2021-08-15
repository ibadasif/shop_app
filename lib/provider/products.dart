import 'package:flutter/foundation.dart';
import '../models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];

  // var _showFavOnly = false;

  List<Product> get items {
    // if (_showFavOnly == true) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://flutter-update-b7923-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavOnly() {
  //   _showFavOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavOnly = false;
  //   notifyListeners();
  // }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutter-update-b7923-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-update-b7923-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could Not Delete Product');
    }
    existingProduct = null;
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://flutter-update-b7923-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
