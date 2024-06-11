import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';

// pages
import 'home.dart';

class GeneratorPage extends StatelessWidget {
  final PageController pageController;
  const GeneratorPage({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair     = appState.current;
    // final theme  = Theme.of(context);

    // NOTE: IconData型の変数iconを宣言し、Iconsクラスのiconを代入
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generator Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 500),
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
                    appState.toggleFavorite();
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
                    appState.getNext();
                  },
                  child: const Text('Next')),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({ super.key, required this.pair, });
  final WordPair pair;

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
            pair.asLowerCase,
            style: theme.textTheme.displayMedium!
            // .copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
