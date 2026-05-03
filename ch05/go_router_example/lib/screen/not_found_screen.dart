import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("페이지를 찾을 수 없음")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("404 - 페이지를 찾을 수 없습니다"),
            SizedBox(height: 20),
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

@Preview(group: "Screen", name: "NotFoundScreen", size: Size(240, 400))
Widget previewNotFoundScreen() => const NotFoundScreen();
