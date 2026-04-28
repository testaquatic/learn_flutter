import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_cart/provider/provider.dart';
import 'package:provider_cart/router/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [productRepositoryProvider, cartModelProvider],
      child: MaterialApp.router(
        title: "장바구니 앱",
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: router,
      ),
    ),
  );
}
