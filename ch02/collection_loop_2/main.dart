class Product {
  final String id;
  final String name;
  final double price;
  final List<String> categories;
  final bool inStock;

  Product(this.id, this.name, this.price, this.categories, this.inStock);
}

void main() {
  final products = [
    Product('p1', '스마트폰', 850000, ['전자제품', '통신기기'], true),
    Product('p2', '노트북', 1200000, ['전자제품', '컴퓨터'], false),
    Product('p3', '헤드폰', 120000, ['전자제품', '오디오'], true),
    Product('p4', '키보드', 98000, ['전자제품', '컴퓨터', '주변기기'], true),
    Product('p5', '마우스', 45000, ['전자제품', '컴퓨터', '주변기기'], true),
    Product('p6', '모니터', 550000, ['전자제품', '컴퓨터', '주변기기'], false),
  ];

  final inStockProducts = products.where((p) => p.inStock);

  final computerProducts = products.where((p) => p.categories.contains('컴퓨터'));

  final sortedByPrice = List<Product>.from(products)
    ..sort((a, b) => a.price.compareTo(b.price));

  final affordablePeripherals = products.where(
    (p) => p.inStock && p.categories.contains("주변기기") && p.price < 100000,
  );

  final productsByCategory = <String, List<Product>>{};

  for (final product in products) {
    for (final category in product.categories) {
      productsByCategory.putIfAbsent(category, () => []);
      productsByCategory[category]!.add(product);
    }
  }

  print("재고 있는 제품: ${inStockProducts.map((p) => p.name)}");
  print("컴퓨터 관련 제품: ${computerProducts.map((p) => p.name)}");
  print("저렴한 주변기기: ${affordablePeripherals.map((p) => p.name)}");
  print("가격순 정렬 : ${sortedByPrice.map((p) => p.name)}");

  print("\n카테고리별 제품:");
  productsByCategory.forEach((category, categoryProducts) {
    print("$category: ${categoryProducts.map((p) => p.name)}");
  });
}
