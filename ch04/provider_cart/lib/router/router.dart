import 'package:go_router/go_router.dart';
import 'package:provider_cart/screen/cart_page.dart';
import 'package:provider_cart/screen/product_list_page.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => ProductListPage()),
    GoRoute(path: "/cart", builder: (context, state) => CartPage()),
  ],
);
