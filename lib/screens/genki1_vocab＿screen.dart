import 'dart:convert';
import 'dart:math';

import 'package:flashcard_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GenkiVocabQuizScreen extends StatefulWidget {
  const GenkiVocabQuizScreen({super.key});
  @override
  GenkiVocabQuizScreenState createState() => GenkiVocabQuizScreenState();
}

class GenkiVocabQuizScreenState extends State<GenkiVocabQuizScreen> {
  List<Map<String, dynamic>> vocabulary = [];
  List<int> selectedChapters = [];
  Map<String, dynamic> currentWord = {};
  List<String> options = [];
  String selectedAnswer = '';
  bool showAnswer = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadVocabulary() async {
    try {
      List<Map<String, dynamic>> loadedVocabulary = [];

      // Load vocabulary for each selected chapter
      for (int chapter in selectedChapters) {
        final String response = await rootBundle.loadString(
            'lib/data/Genki1/chapter_$chapter.json'); // Adjust path to your structure
        final List<dynamic> data = json.decode(response);
        loadedVocabulary
            .addAll(data.cast<Map<String, dynamic>>()); // Add chapter's vocab
      }

      setState(() {
        vocabulary = loadedVocabulary;
      });
    } catch (e) {
      print("Error loading vocabulary: $e");
    }
  }

  void _startQuiz() async {
    if (selectedChapters.isEmpty) {
      setState(() {
        selectedChapters =
            List.generate(12, (index) => index + 1); // Default to all chapters
      });
    }

    await _loadVocabulary();
    _nextQuestion();
  }

  void _nextQuestion() {
    if (vocabulary.isNotEmpty) {
      setState(() {
        showAnswer = false;
        selectedAnswer = '';
        currentWord = vocabulary[Random().nextInt(vocabulary.length)];
        options = _generateOptions(currentWord['meaning']);
      });
    } else {
      print("No vocabulary available for the selected chapters.");
    }
  }

  List<String> _generateOptions(String correctAnswer) {
    List<String> optionPool =
        vocabulary.map((word) => word['meaning'] as String).toSet().toList();
    optionPool.remove(correctAnswer);
    optionPool.shuffle();
    return ([correctAnswer] + optionPool.take(3).toList())..shuffle();
  }

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showAnswer = true;
      if (answer == currentWord['meaning']) {
        score++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genki Vocabulary Quiz'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Select chapters
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(12, (index) {
                  final chapter = index + 1;
                  return FilterChip(
                    label: Text('Chapter $chapter'),
                    selected: selectedChapters.contains(chapter),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedChapters.add(chapter);
                        } else {
                          selectedChapters.remove(chapter);
                        }
                      });
                    },
                  );
                }),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _startQuiz,
                  child: const Text('Start Quiz'),
                ),
              ),
              const SizedBox(height: 20),
              // Quiz Content
              if (currentWord.isNotEmpty)
                Column(
                  // spacing: 10.0,
                  // runSpacing: 10.0,
                  children: [
                    Text(
                      currentWord['vocab'] ?? '',
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '(${currentWord['reading'] ?? ''})',
                      style: const TextStyle(
                          fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10.0, // Space between buttons horizontally
                      runSpacing: 10.0, // Space between buttons vertically
                      children: options
                          .map((option) => SizedBox(
                                width: (MediaQuery.of(context).size.width -
                                        60) /
                                    2, // Half of the available width minus padding
                                child: ElevatedButton(
                                  onPressed: () => _selectAnswer(option),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: showAnswer
                                        ? (option == currentWord['meaning']
                                            ? Colors.green
                                            : (option == selectedAnswer &&
                                                    option !=
                                                        currentWord['meaning']
                                                ? Colors.red
                                                : null))
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
            ],
          ),
        ),
      ),
    );
  }
}
