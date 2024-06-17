import 'package:flutter/material.dart';

class LoginMethodPage extends StatelessWidget {
  const LoginMethodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLoginButton(
                context,
                text: 'Email',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              const SizedBox(height: 20),
              _buildLoginButton(
                context,
                text: 'Google',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Google login is not yet implemented.'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildLoginButton(
                context,
                text: 'LINE',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('LINE login is not yet implemented.'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildLoginButton(
                context,
                text: 'Apple',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Apple login is not yet implemented.'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, {
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 18.0),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
