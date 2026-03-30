import 'package:flutter/material.dart';

class UserData {
  final String name;
  final String email;

  UserData({required this.name, required this.email});
}

class UserProvider extends InheritedWidget {
  final UserData userData;

  const UserProvider({super.key, required this.userData, required super.child});

  static UserProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<UserProvider>();
    assert(provider != null, "UserProvider가 위젯 트리에 없습니다");
    return provider!;
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return userData.name != oldWidget.userData.name ||
        userData.email != oldWidget.userData.email;
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = UserProvider.of(context).userData;

    return Card(
      child: Column(
        children: [
          Text("이름: ${userData.name}"),
          Text("이메일: ${userData.email}"),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProvider(
        userData: UserData(name: "홍길동", email: "hong@example.com"),
        child: HomeScreen(),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
