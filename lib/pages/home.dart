import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Pages
import 'generator_page.dart';
import 'swipe_page.dart';
import 'favorite_page.dart';
import 'profile_page.dart';

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
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Person',
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
      case 2:
        return const ProfilePage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }
}
