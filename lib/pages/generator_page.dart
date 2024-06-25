import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Models
import '../models/word_pair_model.dart';

// State
import '../provider/word_pair_provider.dart';
import '../provider/auth_provider.dart';

// Pages
import 'welcome_page.dart';

class GeneratorPage extends StatefulWidget {
  final PageController pageController;
  const GeneratorPage({Key? key, required this.pageController}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var wordPair = context.watch<WordPairProvider>();
    var pair     = wordPair.current;

    // NOTE: IconData型の変数iconを宣言し、Iconsクラスのiconを代入
    IconData icon;
    if (wordPair.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Generator Page'),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _isLoading ? null : () => _handleLogout(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  widget.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut
                  );
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BigCard(pair: pair),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: theme.colorScheme.background,
                        // foregroundColor: theme.colorScheme.onBackground,
                      ),
                      onPressed: () {
                        wordPair.toggleFavorite();
                      },
                      icon: Icon(icon),
                      label: const Text('Like'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: theme.colorScheme.secondary,
                        // foregroundColor: theme.colorScheme.onSecondary,
                      ),
                      onPressed: () {
                        wordPair.getNext();
                      },
                      child: const Text('Next')),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        if (_isLoading)
          const Material(
            color: Colors.black54,
            child: Center(child: CircularProgressIndicator(),),
          ),
      ],
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<AuthProvider>().logout();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const WelcomePage(),
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
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class BigCard extends StatelessWidget {
  const BigCard({ super.key, required this.pair, });
  final WordPairModel pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      // color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),

        // NOTE: TextウィジェットでsemanticLabelプロパティは使用できなかった
        child: Semantics(
          label: "${pair.first} ${pair.second}",
          child: Text(
            "${pair.first}${pair.second}",
            style: theme.textTheme.displayMedium!
            // .copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
