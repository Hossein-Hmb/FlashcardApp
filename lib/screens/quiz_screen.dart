import 'dart:math';
import 'package:flutter/material.dart';
import '../models/kanji_card.dart';
import '../data/kanji_loader.dart';
import '../utils/constants.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  List<KanjiCard> kanjiCards = [];
  int currentIndex = 0;
  int score = 0;
  bool showAnswer = false;
  String selectedAnswer = '';
  late KanjiCard currentCard;
  List<String> currentOptions = []; // Holds the current options
  String selectedLevel = 'All Levels'; // Default to "All Levels"

  @override
  void initState() {
    super.initState();
    _loadKanjiCards(selectedLevel); // Load the default level (All Levels)
  }

  // Function to load kanji data based on the selected level
  Future<void> _loadKanjiCards(String level) async {
    setState(() {
      kanjiCards = []; // Reset the list before loading new data
      currentIndex = 0;
    });

    List<KanjiCard> loadedCards = [];

    // Load data based on selected level
    if (level == 'All Levels') {
      loadedCards = [
        ...await KanjiLoader.loadKanjiCards('N5'),
        ...await KanjiLoader.loadKanjiCards('N4'),
        ...await KanjiLoader.loadKanjiCards('N3'),
      ];
    } else {
      loadedCards = await KanjiLoader.loadKanjiCards(level);
    }

    setState(() {
      kanjiCards = loadedCards;
      if (kanjiCards.isNotEmpty) {
        currentCard = kanjiCards[currentIndex];
        currentOptions =
            _generateOptions(); // Generate options for the first card
      }
      showAnswer = false;
      selectedAnswer = '';
      score = 0; // Reset score when level changes
    });
  }

  // Function to go to the next question randomly
  void _nextQuestion() {
    if (kanjiCards.isNotEmpty) {
      setState(() {
        currentIndex = Random().nextInt(kanjiCards.length);
        currentCard = kanjiCards[currentIndex];
        currentOptions =
            _generateOptions(); // Generate new options for the new card
        showAnswer = false;
        selectedAnswer = '';
      });
    }
  }

  // Function to handle answer selection
  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showAnswer = true; // Reveal correct and incorrect answer colors
      if (answer == currentCard.meaning) {
        score++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading spinner if kanjiCards is empty
    if (kanjiCards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kanji Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Kanji Quiz')),
      body: Center(
        // Center the entire column horizontally and vertically
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dropdown for selecting kanji level
              DropdownButton<String>(
                value: selectedLevel,
                items: ['All Levels', 'N5', 'N4', 'N3'].map((level) {
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
                    _loadKanjiCards(
                        newLevel); // Reload kanji data based on new level
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Score: $score',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              Text(
                currentCard.kanji, // Display the current kanji
                style:
                    const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              Text(
                currentCard.onyomi, // Display the onyomi of the kanji
                style: const TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                currentCard.kunyomi, // Display the kunyomi of the kanji
                style: const TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              // Display answer options
              Wrap(
                spacing: 10.0, // Space between buttons horizontally
                runSpacing: 10.0, // Space between buttons vertically
                children: currentOptions
                    .map((option) => SizedBox(
                          width: (MediaQuery.of(context).size.width - 60) /
                              2, // Half of the available width minus padding
                          child: ElevatedButton(
                            onPressed: () => _selectAnswer(option),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  showAnswer && option == currentCard.meaning
                                      ? Colors.green
                                      : (showAnswer &&
                                              option == selectedAnswer &&
                                              option != currentCard.meaning)
                                          ? Colors.red
                                          : null,
                            ),
                            child: Text(option),
                          ),
                        ))
                    .toList(),
              ),

              const SizedBox(height: 20),
              if (showAnswer)
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: const Text('Next Question'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Generate answer options, including one correct and three random incorrect answers
  List<String> _generateOptions() {
    List<String> optionPool = kanjiCards.map((card) => card.meaning).toList();
    optionPool.shuffle();
    optionPool.remove(currentCard.meaning);
    return ([currentCard.meaning] + optionPool.take(3).toList())..shuffle();
  }
}
