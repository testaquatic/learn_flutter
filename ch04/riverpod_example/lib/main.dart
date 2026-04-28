import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/screen/todo_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(child: ProviderScope(child: TodoScreen())),
    ),
  );
}
