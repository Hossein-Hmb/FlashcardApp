class VocabCard {
  final String vocab; // The vocabulary word
  final String reading; // The phonetic reading (hiragana/katakana)
  final String meaning; // The English meaning
  final List<String> examples; // Example sentences

  VocabCard({
    required this.vocab,
    required this.reading,
    required this.meaning,
    required this.examples,
  });

  // Factory constructor to create a VocabCard from JSON
  factory VocabCard.fromJson(Map<String, dynamic> json) {
    return VocabCard(
      vocab: json['vocab'] as String,
      reading: json['reading'] as String,
      meaning: json['meaning'] as String,
      examples: List<String>.from(json['examples'] ?? []),
    );
  }

  // Convert a VocabCard to JSON (optional, if needed)
  Map<String, dynamic> toJson() {
    return {
      'vocab': vocab,
      'reading': reading,
      'meaning': meaning,
      'examples': examples,
    };
  }
}
