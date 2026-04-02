import 'package:flutter/material.dart' hide ThemeData;
import 'package:inherited_widget/inherited_widget.dart';

void main() {
  runApp(
    ThemeInherited(
      themeData: ThemeData(
        primaryColor: Colors.blue,
        secondaryColor: Colors.green,
        fontSize: 16.0,
      ),
      child: MyApp(),
    ),
  );
}

class ThemeText extends StatelessWidget {
  final String text;

  const ThemeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeInherited.of(context).themeData;

    return Text(
      text,
      style: TextStyle(color: theme.primaryColor, fontSize: theme.fontSize),
    );
  }
}
