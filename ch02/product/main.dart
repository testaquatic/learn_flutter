class Product {
  final String id;
  final String name;
  final double price;
  final List<String> categories;
  final bool inStock;

  const Product(this.id, this.name, this.price, this.categories, this.inStock);
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

  final sortedByPrice = List.from(products)
    ..sort((a, b) => a.price.compareTo(b.price));

  final affordablePeripherials = products.where(
    (p) => p.inStock && p.categories.contains('주변기기') && p.price < 100_000,
  );

  final productByCategory = <String, List<Product>>{};

  for (final product in products) {
    for (final category in product.categories) {
      productByCategory.update(category, (products) {
        products.add(product);
        return products;
      }, ifAbsent: () => [product]);
    }
  }

  print("재고 있는 재품: ${inStockProducts.map((p) => p.name).join(', ')}");
  print("컴퓨터 관련 제품: ${computerProducts.map((p) => p.name).join(', ')}");
  print("저렴한 주변기기: ${affordablePeripherials.map((p) => p.name).join(', ')}");
  print("가격순 정렬: ${sortedByPrice.map((p) => p.name).join(', ')}");
  print("\n카테고리별 제품");
  productByCategory.forEach((category, categoryProducts) {
    print("$category: ${categoryProducts.map((p) => p.name).join(', ')}");
  });
}
