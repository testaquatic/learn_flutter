import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyAnimationWidget()));
}

class MyAnimationWidget extends StatefulWidget {
  const MyAnimationWidget({super.key});

  @override
  State<MyAnimationWidget> createState() => _MyAnimationWidgetState();
}

class _MyAnimationWidgetState extends State<MyAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("이 텍스트는 다시 그려지지 않습니다."),
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * pi,
                child: Container(width: 100, height: 100, color: Colors.blue),
              );
            },
          ),
        ),
        Text("이 텍스트는 다시 그려지지 않습니다."),
      ],
    );
  }
}
