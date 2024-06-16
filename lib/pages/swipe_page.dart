import 'package:flutter/material.dart';

class SwipePage extends StatelessWidget {
  final PageController pageController;
  const SwipePage({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut
            );
          },
        ),
      ),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
