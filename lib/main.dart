import 'package:flutter/material.dart';
import 'package:flu_demo_app/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.grey[900]!, // 主要な色
            onPrimary: Colors.white, // 主要な色の上のテキスト色
            secondary: Colors.grey[700]!, // 二次的な色
            onSecondary: Colors.white, // 二次的な色の上のテキスト色
            error: Colors.red[800]!, // エラー色
            onError: Colors.white, // エラー色の上のテキスト色
            background: Colors.grey[50]!, // 背景色
            onBackground: Colors.black, // 背景色の上のテキスト色
            surface: Colors.grey[100]!, // 表面色
            onSurface: Colors.black,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
