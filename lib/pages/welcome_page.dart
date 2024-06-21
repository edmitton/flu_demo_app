import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget{
  final VoidCallback onSignUpPressed;
  final VoidCallback onLoginPressed;

  const WelcomePage({
    Key? key,
    required this.onSignUpPressed,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/vinumy_icon.webp',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 32),
              _buildButton(
                context,
                text: 'アカウントを作成する',
                onPressed: onSignUpPressed,
              ),
              const SizedBox(height: 20),
              _buildButton(
                context,
                text: 'ログイン',
                onPressed: onLoginPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {
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
