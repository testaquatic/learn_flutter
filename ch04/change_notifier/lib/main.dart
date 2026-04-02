import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(body: SafeArea(child: MyWidget())),
    ),
  );
}

class UserModel extends ChangeNotifier {
  String _name = "";
  int _age = 0;
  bool _isActive = false;

  String get name => _name;
  int get age => _age;
  bool get isActive => _isActive;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }

  void toggleActive() {
    _isActive = !isActive;
    notifyListeners();
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _userModel = UserModel();

  @override
  void dispose() {
    _userModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _userModel,
      builder: (context, child) {
        return Column(
          children: [
            Text("이름: ${_userModel.name}"),
            Text("나이: ${_userModel.age}"),
            Text("활성화 여부: ${_userModel.isActive ? "활성" : "비활성"}"),
            ElevatedButton(
              onPressed: () => _userModel.updateName("홍길동"),
              child: const Text("이름 변경"),
            ),
            ElevatedButton(
              onPressed: () => _userModel.updateAge(30),
              child: const Text("나이 변경"),
            ),
            ElevatedButton(
              onPressed: () => _userModel.toggleActive(),
              child: const Text("상태 토글"),
            ),
          ],
        );
      },
    );
  }
}
