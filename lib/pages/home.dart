import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'package:logger/logger.dart';

class MyAppState extends ChangeNotifier{
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final logger = Logger();

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const FavoritePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            // NOTE: backgroundであれば自動で適応されてそうでなくてもよさそう
            backgroundColor: theme.colorScheme.background,
            title: Text(
              'Flutter Demo',
              style: TextStyle(color: theme.colorScheme.onBackground)
            ),
          ),
          body: Column(
            children: [
              // SafeArea(
              //   child: NavigationRail(
              //     // extended: constraints.maxWidth > 600,
              //     extended: false,
              //     selectedIndex: selectedIndex,
              //     destinations: const [
              //       NavigationRailDestination(
              //         icon: Icon(Icons.home),
              //         label: Text('Home'),
              //       ),
              //       NavigationRailDestination(
              //         icon: Icon(Icons.favorite),
              //         label: Text('Favorites'),
              //       ),
              //     ],
              //     onDestinationSelected: (value) {
              //       logger.d('selected: $value');
              //       setState(() {
              //         selectedIndex = value;
              //       });
              //     },
              //   ),
              // ),
              Expanded(
                child: Container(
                  color: theme.colorScheme.background,
                  child: page,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar (
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (value) {
              logger.d('selected: $value');
              setState(() {
                selectedIndex = value;
              });
          }),
        );
      }
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair     = appState.current;
    final theme  = Theme.of(context);

    // NOTE: IconData型の変数iconを宣言し、Iconsクラスのiconを代入
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BigCard(pair: pair),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: const Text('Like'),
              ),
              const SizedBox(width: 10),
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
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appState.favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.favorite),
                  title: Text(appState.favorites[index].asLowerCase),
                );
              }
            ),
          ),
        ],
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

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),

        // NOTE: TextウィジェットでsemanticLabelプロパティは使用できなかった
        child: Semantics(
          label: "${pair.first} ${pair.second}",
          child: Text(
            pair.asLowerCase,
            style: theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
