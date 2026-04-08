import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final appRouter = AppRouter();

          return MaterialApp.router(
            title: "할 일 관리 앱",
            theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
