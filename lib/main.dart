import 'package:flu_drinks/components/app_color.dart';
import 'package:flu_drinks/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kebuke',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorAccent),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
