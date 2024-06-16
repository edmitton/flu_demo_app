import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:logger/logger.dart';

// pages
import 'generator_page.dart';
import 'swipe_page.dart';
import 'favorite_page.dart';

class MyAppState extends ChangeNotifier{
  var current   = WordPair.random();
  var favorites = <WordPair>[];
  bool isLoggedIn = false;

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
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
  final logger = Logger();
  bool showBottomNavBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: selectedIndex == 1 ? const NeverScrollableScrollPhysics() : null,
        onPageChanged: (index) {
          setState(() {
            showBottomNavBar = index == 0;
          });
        },
        children: [
          Scaffold(
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
          SwipePage(pageController: _pageController),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return GeneratorPage(pageController: _pageController);
      case 1:
        return const FavoritePage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }
}
