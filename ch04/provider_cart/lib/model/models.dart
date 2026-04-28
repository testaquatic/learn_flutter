import 'package:flutter/material.dart';

/// 상품모델
/// id와 name, price, imageUrl 필드가 있다.
class Product {
  final String id;
  final String name;
  final int price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

/// 장바구니 모델
/// ChangeNotifier를 상속한다.
/// 상품을 추가하고, 삭제하고, 비울 수 있다.
/// _items 비공개 필드는 상품 목록을 저장한다.
/// itemCount 게터는 장바구니에 있는 상품의 수를 반환한다.
/// totalPrice 게터는 전체 가격을 반환한다.
class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  int get totalPrice => _items.fold(0, (total, item) => total + item.price);

  void addProuct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// 하드코딩한 상품 저장소
class ProductRepository {
  // 상품 목록 (실제로는 API에서 가져옴)
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
