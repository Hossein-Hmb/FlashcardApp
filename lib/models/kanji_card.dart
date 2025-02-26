class KanjiCard {
  final String kanji;
  final String meaning;
  final String onyomi; // Changed from List<String> to String
  final String kunyomi; // Changed from List<String> to String
  final List<String> examples;
  final String level;

  KanjiCard({
    required this.kanji,
    required this.meaning,
    required this.onyomi,
    required this.kunyomi,
    this.examples = const [],
    this.level = 'N5',
  });

  // Factory constructor to create a KanjiCard from JSON
  factory KanjiCard.fromJson(Map<String, dynamic> json) {
    return KanjiCard(
      kanji: json['character'] as String, // Changed key from kanji to character
      meaning: json['meaning'] as String,
      onyomi: json['onyomi'] as String, // Directly reads as String
      kunyomi: json['kunyomi'] as String, // Directly reads as String
      examples: List<String>.from(json['examples'] ?? []),
      level: json['level'] ?? 'N5',
    );
  }

  // Convert a KanjiCard instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'kanji': kanji,
      'meaning': meaning,
      'onyomi': onyomi,
      'kunyomi': kunyomi,
      'examples': examples,
    };
  }
}
