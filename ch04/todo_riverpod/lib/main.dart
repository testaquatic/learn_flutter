import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/page/todo_page.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: TodoScreen())));
}
