import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedInProvider = NotifierProvider<IsLoggedIn, bool>(IsLoggedIn.new);

class IsLoggedIn extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void login() {
    state = true;
  }

  void logout() {
    state = false;
  }
}
