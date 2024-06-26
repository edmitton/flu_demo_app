import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// State
import 'provider/word_pair_provider.dart';
import 'provider/auth_provider.dart';
import 'provider/welcome_page_provider.dart';

// Pages
import 'pages/welcome_page.dart';
import 'pages/home.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordPairProvider(),),
        ChangeNotifierProvider(create: (context) => AuthProvider(),),
        ChangeNotifierProvider(create: (context) => WelcomePageProvider(),),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
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
            initialRoute: auth.isLoggedIn ? '/home' : '/welcome',
            routes: {
              '/welcome': (context) => const WelcomePage(),
              '/home': (context) => const MyHomePage(),
              '/login': (context) => const LoginPage(),
            },
          );
        },
      ),
    );
  }
}
