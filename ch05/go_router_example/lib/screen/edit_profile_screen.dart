import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("프로필 수정")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("프로필 수정 화면"),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text("뒤로 가기"),
            ),
          ],
        ),
      ),
    );
  }
}

@Preview(group: "Screen", name: "EditProfileScreen", size: Size(240, 400))
Widget previewEditProfileScreen() => EditProfileScreen();
