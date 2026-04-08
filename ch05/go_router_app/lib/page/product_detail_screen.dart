import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("제품 상세")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("상품 ID: $productId의 상세 정보"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go("/");
              },
              child: const Text("홈으로 돌아가기"),
            ),
          ],
        ),
      ),
    );
  }
}
