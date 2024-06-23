import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// States
import '../provider/welcome_page_provider.dart';

class WelcomePage extends StatefulWidget {
  final bool initialShowLoginSelection;
  const WelcomePage({Key? key, this.initialShowLoginSelection = true}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WelcomePageProvider>(context, listen: false).setInitialView(widget.initialShowLoginSelection);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewState = Provider.of<WelcomePageProvider>(context);

    return Scaffold(
     appBar: AppBar(
        leading: Consumer<WelcomePageProvider>(
          builder: (context, viewState, _) {
            return viewState.showLoginSelection
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: viewState.toggleView,
                );
          },
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
                firstChild: _buildSelectionButtons(context),
                secondChild: _buildLoginMethodButtons(context),
                crossFadeState: viewState.showLoginSelection
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionButtons(BuildContext context) {
    final viewState = Provider.of<WelcomePageProvider>(context, listen: false);

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
          onPressed: viewState.toggleView,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLoginMethodButtons(BuildContext context) {
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
        const SizedBox(height: 20),
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
