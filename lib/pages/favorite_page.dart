import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// State
import '../provider/word_pair_provider.dart';

// pages

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wordPair = context.watch<WordPairProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Page'),
      ),
      body: wordPair.favorites.isEmpty ?
        const Center(
          child: Text('No favorites yet.'),
        )
        : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: wordPair.favorites.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(wordPair.favorites[index].toString()),
                  );
                }
              ),
            ),
          ],
        ),
    );
  }
}
