import 'dart:math';
import 'package:flutter/material.dart';
import '../models/kanji_card.dart';
import '../data/kanji_loader.dart';
import '../utils/constants.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});
  @override
  FlashcardScreenState createState() => FlashcardScreenState();
}

class FlashcardScreenState extends State<FlashcardScreen> {
  List<KanjiCard> kanjiCards = [];
  int currentIndex = 0;
  bool showDetails = false;
  String selectedLevel = 'N5';

  @override
  void initState() {
    super.initState();
    _loadKanjiCards(selectedLevel);
  }

  // Function to load kanji data
  Future<void> _loadKanjiCards(String level) async {
    setState(() {
      kanjiCards = []; // Reset list before loading new data
      currentIndex = 0;
    });

    final loadedCards = await KanjiLoader.loadKanjiCards(level);
    setState(() {
      kanjiCards = loadedCards;
      if (kanjiCards.isNotEmpty) {
        currentIndex = 0; // Ensure currentIndex is valid
      }
      showDetails = false;
    });
  }

  // Function to select a random card if kanjiCards is not empty
  void _nextCard() {
    if (kanjiCards.isNotEmpty) {
      setState(() {
        currentIndex = Random().nextInt(kanjiCards.length);
        showDetails = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading spinner if kanjiCards is empty
    if (kanjiCards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kanji Flashcards')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentCard = kanjiCards[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Kanji Flashcards')),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: Column(
            children: [
              // Dropdown for selecting kanji level
              DropdownButton<String>(
                value: selectedLevel,
                items: jlptLevels.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (newLevel) {
                  if (newLevel != null) {
                    setState(() {
                      selectedLevel = newLevel;
                    });
                    _loadKanjiCards(newLevel);
                  }
                },
              ),
              const SizedBox(height: 20),
              // Display the flashcard widget only if currentCard is defined
              Expanded(
                child: FlashcardWidget(kanjiCard: currentCard),
              ),
              const SizedBox(height: 20),
              // Button to go to the next random card
              ElevatedButton(
                onPressed: _nextCard,
                child: const Text('Next Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
