import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/router.dart';

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
          final router = ref.watch(routerProvier);
          return MaterialApp.router(
            title: '할 일 관리 앱',
            theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
            routerConfig: router,
          );
        },
      ),
    );
  }
}

@Preview(group: "screen", name: "MyApp", size: Size(480, 800))
Widget previewMyApp() => ProviderScope(child: MyApp());
