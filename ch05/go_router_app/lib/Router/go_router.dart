import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_app/Provider/appstate.dart';
import 'package:go_router_app/page/edit_profile_screen.dart';
import 'package:go_router_app/page/home_screen.dart';
import 'package:go_router_app/page/login_screen.dart';
import 'package:go_router_app/page/not_found_screen.dart';
import 'package:go_router_app/page/order_history_screen.dart';
import 'package:go_router_app/page/product_detail_screen.dart';
import 'package:go_router_app/page/profile_screen.dart';
import 'package:go_router_app/page/setting_screen.dart';

GoRouter router(WidgetRef ref) {
  return GoRouter(
    initialLocation: "/",
    refreshListenable: ref.watch(isLoggedInProvider.notifier),
    redirect: (context, state) {
      final protectedRoutes = ["/profile", "/settings"];
      final isLoggedIn = ref.watch(isLoggedInProvider);

      final isProtectedRoute = protectedRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      if (!isLoggedIn && isProtectedRoute) {
        return "/login?redirect=${state.matchedLocation}";
      }

      if (isLoggedIn && state.matchedLocation == "/login") {
        return "/";
      }

      return null;
    },

    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) {
          final redirectUrl = state.uri.queryParameters["redirect"] ?? "/";
          return LoginScreen(redirectUrl: redirectUrl);
        },
      ),
      GoRoute(
        path: "/product/:productId",
        builder: (context, state) {
          final productId = state.pathParameters["productId"];
          if (productId == null) {
            return NotFoundScreen();
          }
          return ProductDetailScreen(productId: productId);
        },
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) {
          return ProfileScreen();
        },
        routes: [
          GoRoute(
            path: "edit",
            builder: (context, state) {
              return EditProfileScreen();
            },
          ),
          GoRoute(
            path: "orders",
            builder: (context, state) {
              return OrderHistoryScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: "/settings",
        builder: (context, state) {
          return SettingScreen();
        },
      ),
    ],
    errorBuilder: (context, state) {
      return NotFoundScreen();
    },
  );
}
