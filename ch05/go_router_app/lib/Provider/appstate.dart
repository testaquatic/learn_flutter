import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appstate.g.dart';

@riverpod
class IsLoggedIn extends _$IsLoggedIn with ChangeNotifier {
  @override
  bool build() => false;

  Future<void> login() async {
    state = true;
    notifyListeners();
  }

  Future<void> logout() async {
    state = false;
    notifyListeners();
  }
}
