import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';

class MyAppState extends ChangeNotifier{
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair     = appState.current;
    final theme  = Theme.of(context);
    const String hogefuga = 'A random AWESOME idea:';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        title: Text(
          'Flutter Mitton App',
          style: TextStyle(color: theme.colorScheme.onBackground)
        ),
      ),
      body: Container(
        color: theme.colorScheme.background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                hogefuga,
                style: TextStyle(fontSize: 20, color: theme.colorScheme.onBackground)
              ),
              BigCard(pair: pair),

              // MyAppStateのgetNext呼び出し
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                ),
                onPressed: () {
                  appState.getNext();
                },
                child: const Text('Next')),
            ],
          ),
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),

        // TextウィジェットでsemanticLabelプロパティは使用できなかった
        child: Semantics(
          label: "${pair.first} ${pair.second}",
          child: Text(
            pair.asLowerCase,
            style: style,
            // style: TextStyle(
            //   fontSize: 20,
            //   color: theme.colorScheme.onPrimary,
            // ),
          ),
        ),
      ),
    );
  }
}
