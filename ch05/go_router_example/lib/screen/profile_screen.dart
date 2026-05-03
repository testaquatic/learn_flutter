import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => context.go("/profile/edit"),
              child: const Text("프로필 수정"),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () => context.go("/profile/orders"),
              child: const Text("주문 내역"),
            ),
          ],
        ),
      ),
    );
  }
}

@Preview(group: "Screen", name: "ProfileScreen", size: Size(240, 400))
Widget previewProfileScreen() => const ProfileScreen();
