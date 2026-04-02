import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get itemCount => _items.length;
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class ProductRepository {
  List<Product> getProducts() {
    return [
      Product(
        id: '1',
        name: '노트북',
        price: 1200000,
        imageUrl: 'assets/laptop.jpg',
      ),
      Product(
        id: '2',
        name: '스마트폰',
        price: 800000,
        imageUrl: 'assets/smartphone.jpg',
      ),
      Product(
        id: '3',
        name: '헤드폰',
        price: 250000,
        imageUrl: 'assets/headphones.jpg',
      ),
      Product(
        id: '4',
        name: '스마트워치',
        price: 350000,
        imageUrl: 'assets/smartwatch.jpg',
      ),
    ];
  }
}
