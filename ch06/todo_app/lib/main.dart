import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/screen/todo_screen.dart';

void main() {
  runApp(MaterialApp(home: ProviderScope(child: TodoScreen())));
}
