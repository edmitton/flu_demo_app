import 'package:flutter/material.dart';

// Models
import '../models/word_pair_model.dart';

// Services
import '../services/word_pair_service.dart';

class WordPairProvider extends ChangeNotifier{
  final WordPairService _wordPairService = WordPairService();
  final List<WordPairModel> _favorites = [];
  late WordPairModel _current;

  WordPairProvider() {
    _current = _wordPairService.generateRandomWordPair();
  }

  WordPairModel get current => _current;
  List<WordPairModel> get favorites => _favorites;

  void getNext() {
    _current = _wordPairService.generateRandomWordPair();
    notifyListeners();
  }

  void toggleFavorite() {
    if (_favorites.contains(_current)) {
      _favorites.remove(_current);
    } else {
      _favorites.add(_current);
    }
    notifyListeners();
  }
}
