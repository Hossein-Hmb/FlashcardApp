import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/kanji_card.dart';

class KanjiLoader {
  // Function to load Kanji data from a JSON file based on level
  static Future<List<KanjiCard>> loadKanjiCards(String level) async {
    String fileName;
    switch (level) {
      case 'N5':
        fileName = 'lib/data/Kanji/n5.json';
        break;
      case 'N4':
        fileName = 'lib/data/Kanji/n4.json';
        break;
      case 'N3':
        fileName = 'lib/data/Kanji/n3.json';
        break;
      default:
        throw Exception('Unsupported level');
    }

    final String response = await rootBundle.loadString(fileName);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => KanjiCard.fromJson(json)).toList();
  }
}
