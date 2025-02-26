import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/vocab_card.dart';

class VocabLoader {
  // Function to load vocabulary data from JSON
  static Future<List<VocabCard>> loadVocabData() async {
    try {
      // Load the JSON file as a string
      final String response =
          await rootBundle.loadString('lib/data/vocab_data.json');
      // Decode the JSON into a list of dynamic objects
      final List<dynamic> data = json.decode(response);
      // Map the JSON objects to a list of VocabCard objects
      return data.map((json) => VocabCard.fromJson(json)).toList();
    } catch (e) {
      print("Error loading vocabulary data: $e");
      return [];
    }
  }
}
