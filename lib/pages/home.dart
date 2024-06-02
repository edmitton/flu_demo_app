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
    const int hogefuga = 100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Flutter Mitton App', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('$hogefuga', style: TextStyle(fontSize: 30, color: Colors.white)),
              Text(appState.current.asLowerCase, style: const TextStyle(fontSize: 30, color: Colors.white)),

              ElevatedButton(
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
