import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_app/Provider/appstate.dart';

class LoginScreen extends ConsumerWidget {
  final String redirectUrl;

  const LoginScreen({super.key, required this.redirectUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("로그인 화면"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref.read(isLoggedInProvider.notifier).login();
                if (context.mounted) {
                  context.go(redirectUrl);
                }
              },
              child: const Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
