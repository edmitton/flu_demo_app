import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// State
import '../provider/auth_provider.dart';

// Pages
import 'welcome_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return const WelcomePage(initialShowLoginSelection: false);
                },
                transitionsBuilder: (context, animation1, animation2, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation1),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 200),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async{
                            setState(() {
                              _isLoading = true;
                            });

                            await Future.delayed(const Duration(seconds: 2));

                            if (_usernameController.text == 'admin' &&
                                _passwordController.text == 'password') {
                              auth.login();
                              if (!mounted) return;
                              Navigator.pushReplacementNamed(context, '/home');
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Incorrect username or password.'),
                                ),
                              );
                            }

                            setState(() {
                              _isLoading = false;
                            });
                          },
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
