import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("설정")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("설정 화면"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go("/"),
              child: const Text("홈으로 돌아가기"),
            ),
          ],
        ),
      ),
    );
  }
}
