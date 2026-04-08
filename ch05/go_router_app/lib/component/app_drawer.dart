import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_app/Provider/appstate.dart';

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
            child: Text(
              "GoRouter 예제",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("홈"),
            onTap: () {
              context.go("/");
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("프로필"),
            onTap: () {
              context.go("/profile");
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("설정"),
            onTap: () {
              context.go("/settings");
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          if (isLoggedIn)
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("로그아웃"),
              onTap: () async {
                await ref.read(isLoggedInProvider.notifier).logout();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            )
          else
            ListTile(
              leading: Icon(Icons.login),
              title: Text("로그인"),
              onTap: () {
                context.go("/login");
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
