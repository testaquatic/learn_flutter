import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/provider/is_login_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: const Text(
              "GoRouter 예제",
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("홈"),
            onTap: () {
              context.go("/");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("프로필"),
            onTap: () {
              context.go("/profile");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("설정"),
            onTap: () {
              context.go("/settings");
              Navigator.pop(context);
            },
          ),
          Divider(),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("로그아웃"),
              onTap: () {
                ref.read(isLoggedInProvider.notifier).logout();
                Navigator.pop(context);
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("로그인"),
              onTap: () {
                context.go("/login");
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}

@Preview(group: "Component", name: "AppDrawer", size: Size(240, 400))
Widget previewAppDrawer() => const ProviderScope(child: AppDrawer());
