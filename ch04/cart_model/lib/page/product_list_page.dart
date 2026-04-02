import 'package:cart_model/model/cart_mdel.dart';
import 'package:cart_model/page/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productRepository = Provider.of<ProductRepository>(context);
    final products = productRepository.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text("상품 목록"),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartPage()),
                  );
                },
                icon: Icon(Icons.shopping_cart),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartModel>(
                  builder: (_, cart, __) {
                    return cart.itemCount > 0
                        ? CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 8,
                            child: Text(
                              "${cart.itemCount}",
                              style: TextStyle(
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
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, size: 56);
                },
              ),
              title: Text(product.name),
              subtitle: Text("₩${product.price.toStringAsFixed(0)}"),
              trailing: Consumer<CartModel>(
                builder: (_, cart, __) {
                  return IconButton(
                    onPressed: () {
                      cart.addProduct(product);
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
