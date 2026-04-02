import 'package:cart_model/model/cart_mdel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("장바구니")),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(child: Text("장바구니가 비었습니다."));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final product = cart.items[index];
                    return ListTile(
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
                      trailing: IconButton(
                        onPressed: () {
                          cart.removeProduct(product);
                        },
                        icon: Icon(Icons.remove_circle),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "총 결제 금액: ₩${cart.totalPrice.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("결제 확인"),
                            content: Text("결제가 완료되었습니다!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  cart.clearCart();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text("확인"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: child,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
