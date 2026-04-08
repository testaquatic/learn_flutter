import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("프로필")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("프로필 화면"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go("/profile/edit");
              },
              child: const Text("프로필 수정"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.go("/profile/orders");
              },
              child: Text("주문 내역"),
            ),
          ],
        ),
      ),
    );
  }
}
