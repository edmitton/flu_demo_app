import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:logger/logger.dart';

// pages
import 'generator_page.dart';
import 'swipe_page.dart';
import 'favorite_page.dart';

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
  final PageController _pageController = PageController();
  bool showBottomNavBar = true;

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final logger = Logger();

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Scaffold(
            appBar: AppBar(
              // NOTE: backgroundであれば自動で適応されてそうでなくてもよさそう
              backgroundColor: theme.colorScheme.background,
              title: Text(
                'Flutter Demo',
                style: TextStyle(color: theme.colorScheme.onBackground)
              ),
            ),
            body: _buildBody(),
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
              },
            ),
          ),
          const SwipePage(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return const GeneratorPage();
      case 1:
        return const FavoritePage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }
}
