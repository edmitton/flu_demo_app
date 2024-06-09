import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

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
