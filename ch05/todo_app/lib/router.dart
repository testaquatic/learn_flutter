import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/providers/todo_providers.dart';
import 'package:todo_app/screen/home_screen.dart';
import 'package:todo_app/screen/not_found_screen.dart';
import 'package:todo_app/screen/profile_screen.dart';
import 'package:todo_app/widgets/scaffold_with_nav_bar.dart';
import 'package:todo_app/screen/stats_screen.dart';
import 'package:todo_app/screen/todo_detail_screen.dart';
import 'package:todo_app/screen/todo_edit_screen.dart';

final routerProvier = Provider(
  (ref) => GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/",
                builder: (context, state) => const HomeScreen(),
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
                    builder: (context, state) => const TodoEditScreen(),
                  ),
                  GoRoute(
                    path: "edit/:id",
                    builder: (context, state) {
                      final id = state.pathParameters["id"]!;
                      final todo = ref.read(getTodoByIdProvider(id));
                      return TodoEditScreen(todo: todo);
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
                builder: (context, state) => const StatsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/profile",
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);
