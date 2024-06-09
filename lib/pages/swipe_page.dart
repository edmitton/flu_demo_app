import 'package:flutter/material.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe Page')),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
