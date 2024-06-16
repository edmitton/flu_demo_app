import 'package:english_words/english_words.dart';

// Models
import '../models/word_pair_model.dart';

class WordPairService {
  WordPairModel generateRandomWordPair() {
    final pair = WordPair.random();
    return WordPairModel(pair.first, pair.second);
  }
}
