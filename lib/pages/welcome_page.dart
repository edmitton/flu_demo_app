import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key,}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool showLoginSelection = true;

  void toggleView() {
    setState(() {
      showLoginSelection = !showLoginSelection;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        leading: showLoginSelection
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: toggleView,
              ),
      ),
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
              AnimatedCrossFade(
                firstChild: _buildSelectionButtons(),
                secondChild: _buildLoginMethodButtons(),
                crossFadeState: showLoginSelection
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionButtons() {
    return Column(
      key: const ValueKey(1),
      children: [
        _buildButton(
          text: 'アカウントを作成する',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign up is not yet implemented.'),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        _buildButton(
          text: 'Login',
          onPressed: toggleView,
        ),
      ],
    );
  }

  Widget _buildLoginMethodButtons() {
    return Column(
      key: const ValueKey(2),
      children: [
        const SizedBox(height: 32),
        _buildButton(
          text: 'Email',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
        const SizedBox(height: 20),
        _buildButton(
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
        _buildButton(
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
        _buildButton(
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
    );
  }

  Widget _buildButton({
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
