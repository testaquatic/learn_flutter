import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ValueNotifierExample()));
}

class ValueNotifierExample extends StatelessWidget {
  ValueNotifierExample({super.key});

  final ValueNotifier<int> _counter = ValueNotifier(0);
  final ValueNotifier<bool> _isActive = ValueNotifier(false);

  void _incrementCounter() {
    _counter.value = _counter.value + 1;
  }

  void _toggleActive() {
    _isActive.value = !_isActive.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ValueNotifier 예제")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _counter,
              builder: (context, value, child) {
                return Text(
                  "카운트: $value",
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: _isActive,
              builder: (context, isActive, child) {
                return Switch(
                  value: isActive,
                  onChanged: (value) => _toggleActive(),
                );
              },
            ),
            Builder(
              builder: (context) {
                return Text(
                  "현재 상태: ${_isActive.value ? "활성" : "비활성"}, 카운트: ${_counter.value}",
                  style: TextStyle(
                    color: _isActive.value ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "증가",
        child: const Icon(Icons.add),
      ),
    );
  }
}
