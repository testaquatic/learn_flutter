import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/provider/is_login_provider.dart';

class LoginScreen extends StatelessWidget {
  final String redirectUrl;

  const LoginScreen({super.key, required this.redirectUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("로그인")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("로그인 화면"),
            const SizedBox(height: 20.0),
            Consumer(
              builder: (context, ref, child) => ElevatedButton(
                onPressed: () {
                  ref.read(isLoggedInProvider.notifier).login();
                  context.go(redirectUrl);
                },
                child: Text("로그인"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@Preview(group: "Screen", name: "LoginScreen", size: Size(240, 400))
Widget previewLoginScreen() => const LoginScreen(redirectUrl: "/");
