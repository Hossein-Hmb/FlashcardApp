import 'dart:math';
import 'package:flutter/material.dart';
import '../data/vocab_loader.dart';
import '../models/vocab_card.dart';

class QuizVocabularyScreen extends StatefulWidget {
  const QuizVocabularyScreen({super.key});
  @override
  QuizVocabularyScreenState createState() => QuizVocabularyScreenState();
}

class QuizVocabularyScreenState extends State<QuizVocabularyScreen> {
  List<VocabCard> vocabList = [];
  int currentIndex = 0;
  int score = 0;
  bool showAnswer = false;
  String selectedAnswer = '';
  late VocabCard currentVocab;
  List<String> currentOptions = []; // Holds the current options

  @override
  void initState() {
    super.initState();
    _loadVocabData();
  }

  // Function to load vocab data
  Future<void> _loadVocabData() async {
    final List<VocabCard> data = await VocabLoader.loadVocabData();
    setState(() {
      vocabList = data;
      if (vocabList.isNotEmpty) {
        currentIndex = 0;
        currentVocab = vocabList[currentIndex];
        currentOptions = _generateOptions();
      }
    });
  }

  // Function to move to the next question randomly
  void _nextQuestion() {
    if (vocabList.isNotEmpty) {
      setState(() {
        currentIndex = Random().nextInt(vocabList.length);
        currentVocab = vocabList[currentIndex];
        currentOptions = _generateOptions();
        showAnswer = false;
        selectedAnswer = '';
      });
    }
  }

  // Function to handle answer selection
  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showAnswer = true;
      if (answer == currentVocab.reading) {
        score++;
      }
    });
  }

  // Generate answer options, including one correct and three random incorrect answers
  List<String> _generateOptions() {
    List<String> optionPool = vocabList.map((item) => item.meaning).toList();
    optionPool.shuffle();
    optionPool.remove(currentVocab.meaning);
    return ([currentVocab.meaning] + optionPool.take(3).toList())..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading spinner if vocabList is empty
    if (vocabList.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Vocabulary Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Vocabulary Quiz')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: $score',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              Text(
                currentVocab.vocab, // Display the vocab word
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                currentVocab.reading, // Display the vocab word
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
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
                                  showAnswer && option == currentVocab.meaning
                                      ? Colors.green
                                      : (showAnswer &&
                                              option == selectedAnswer &&
                                              option != currentVocab.meaning)
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
}
