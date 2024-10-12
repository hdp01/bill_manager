import 'package:flutter/material.dart';
import 'package:bill_manager/screens/home_screen.dart';
import 'widgets/custom_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Manager',
      theme: CustomTheme.lightTheme,
      home: HomeScreen(), // HomeScreen as the starting point
    );
  }
}
