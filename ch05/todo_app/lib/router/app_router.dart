import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/profile_screen.dart';
import 'package:todo_app/screens/stats_screen.dart';
import 'package:todo_app/screens/todo_detail_screen.dart';
import 'package:todo_app/screens/todo_edit_screen.dart';

class AppRouter {
  AppRouter();

  late final router = GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavbar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/",
                builder: (context, state) {
                  return const HomeScreen();
                },
                routes: [
                  GoRoute(
                    path: "todo/:id",
                    builder: (context, state) {
                      final id = state.pathParameters["id"]!;
                      return TodoDetailScreen(todoId: id);
                    },
                  ),
                  GoRoute(
                    path: "add",
                    builder: (context, state) {
                      return const TodoEditScreen();
                    },
                  ),
                  GoRoute(
                    path: "edit/:id",
                    builder: (context, state) {
                      final id = state.pathParameters["id"]!;
                      return TodoEditScreen(todoId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/stats",
                builder: (context, state) {
                  return const StatsScreen();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/profile",
                builder: (context, state) {
                  return const ProfileScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text("페이지를 찾을 수 없음")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("요청한 페이지를 찾을 수 없습니다."),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go("/");
                },
                child: const Text("홈으로 돌아가기"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ScaffoldWithNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavbar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "통계"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "프로필"),
        ],
        onTap: (index) {
          navigationShell.goBranch(index);
        },
      ),
    );
  }
}
