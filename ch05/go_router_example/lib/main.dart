import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_example/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final router = ref.watch(routerProvider);
          return MaterialApp.router(
            title: "GoRouter Example",
            theme: ThemeData(primarySwatch: Colors.blue),
            routerConfig: router,
          );
        },
      ),
    );
  }
}

@Preview(group: "Screen", name: "MyApp", size: Size(240, 400))
Widget previewMyApp() => const MyApp();
