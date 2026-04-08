import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_app/component/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  @Preview(name: "HomeScreen")
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("홈")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("홈 화면"),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  final productId = index + 1;
                  return ListTile(
                    title: Text("상품 $productId"),
                    onTap: () => context.go("/product/$productId"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
