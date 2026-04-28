import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_cart/model/models.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('장바구니')),
        body: Consumer<CartModel>(
          builder: (context, cart, child) {
            if (cart.items.isEmpty) {
              return const Center(child: Text('장바구니가 비었습니다.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.itemCount,
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
                            cart.remove(product);
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
                        blurRadius: 4,
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
                        child: const Text("결제하기"),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("결제 확인"),
                              content: const Text("결제가 완료되었습니다."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cart.clear();
                                    context.pop();
                                    context.pop();
                                  },
                                  child: const Text("확인"),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

@Preview(name: "CartPage", group: "screen")
Widget previewCartPage() {
  return Provider(create: (_) => CartModel(), child: CartPage());
}
