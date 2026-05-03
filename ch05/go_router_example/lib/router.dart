import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/provider/is_login_provider.dart';
import 'package:go_router_example/screen/edit_profile_screen.dart';
import 'package:go_router_example/screen/login_screen.dart';
import 'package:go_router_example/screen/not_found_screen.dart';
import 'package:go_router_example/screen/order_history_screen.dart';
import 'package:go_router_example/screen/product_detail_screen.dart';
import 'package:go_router_example/screen/profile_screen.dart';
import 'package:go_router_example/screen/settings_screen.dart';

import 'screen/home_screen.dart';

final routerProvider = Provider((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);

  return GoRouter(
    initialLocation: "/",
    refreshListenable: _LoginStateNotifier(ref),
    redirect: (context, state) {
      // 인증이 필요한 섹션의 접근 권한을 확인한다.
      final protectedRoutes = ["/profile", "/settings"];

      final isProtectedRoute = protectedRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      // 로그인하지 않았다면 로그인 화면으로 이동한다.
      if (!isLoggedIn && isProtectedRoute) {
        return "/login?redirect=${state.matchedLocation}";
      }

      // 로그인한 상태에서 로그인 화면이라면 홈 화면으로 이동한다.
      if (isLoggedIn && state.matchedLocation == "/login") {
        return "/";
      }

      return null;
    },
    routes: [
      // 홈 스크린
      GoRoute(path: "/", builder: (context, state) => HomeScreen()),

      // 로그인 스크린
      GoRoute(
        path: "/login",
        builder: (context, state) {
          // redirect 쿼리가 없으면 홈화면으로 이동한다.
          final redirectUrl = state.uri.queryParameters["redirect"] ?? "/";
          return LoginScreen(redirectUrl: redirectUrl);
        },
      ),

      // 상품 상세 화면
      GoRoute(
        path: "/product/:id",
        builder: (context, state) {
          final productId = state.pathParameters["id"]!;
          return ProductDetailScreen(productId: productId);
        },
      ),

      // 프로필 섹션
      GoRoute(
        // 프로필 화면
        path: "/profile",
        builder: (context, state) => const ProfileScreen(),
        routes: [
          // 프로필 편집 화면
          GoRoute(
            path: "edit",
            builder: (context, state) => EditProfileScreen(),
          ),
          // 주문 내역 화면
          GoRoute(
            path: "orders",
            builder: (context, state) => const OrderHistoryScreen(),
          ),
        ],
      ),
      // 설정화면
      GoRoute(path: "/settings", builder: (context, state) => SettingsScreen()),
    ],
    // 경로를 찾을 수 없을 때
    errorBuilder: (context, state) => NotFoundScreen(),
  );
});

class _LoginStateNotifier extends ChangeNotifier {
  final Ref ref;

  _LoginStateNotifier(this.ref) {
    ref.listen<bool>(isLoggedInProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }
}
