import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//pages
import '/pages/home.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: Consumer<MyAppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.lightBlue,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: const ColorScheme.dark(
                primary: Colors.lightBlue,
              ),
            ),
            themeMode: ThemeMode.system,
            initialRoute: appState.isLoggedIn ? '/home' : '/login',
            routes: {
              '/home': (context) => const MyHomePage(),
              '/login': (context) => const LoginPage(),
            },
          );
        },
      ),
    );
  }
}
