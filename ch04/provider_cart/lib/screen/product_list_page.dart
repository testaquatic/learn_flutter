import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_cart/model/models.dart';
import 'package:provider_cart/provider/provider.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productRepository = Provider.of<ProductRepository>(context);
    final products = productRepository.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 목록'),
        actions: [
          IconButton(
            onPressed: () {
              context.push("/cart");
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Consumer<CartModel>(
              builder: (_, cart, _) {
                return cart.itemCount > 0
                    ? CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 8,
                        child: Text(
                          "${cart.itemCount}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(
                product.imageUrl,
                width: 56,
                height: 56,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image, size: 56),
              ),
              title: Text(product.name),
              subtitle: Text("₩${product.price.toStringAsFixed(0)}"),
              trailing: Consumer<CartModel>(
                builder: (_, cart, _) {
                  return IconButton(
                    onPressed: () {
                      cart.addProuct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${product.name} 추가됨")),
                      );
                    },
                    icon: Icon(Icons.add_shopping_cart),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

@Preview(name: "ProductListPage", group: "screen")
Widget previewProductListPange() {
  return MultiProvider(
    providers: [productRepositoryProvider, cartModelProvider],
    child: ProductListPage(),
  );
}
