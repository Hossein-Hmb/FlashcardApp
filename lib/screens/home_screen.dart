import 'package:flutter/material.dart';
import 'flashcard_screen.dart';
import 'quiz_screen.dart'; // Assuming you'll create this for the quiz functionality
import 'settings_screen.dart'; // Assuming you'll create this for settings
import 'quiz_screen_kunyomi.dart';
import 'vocabulary_screen.dart';
import 'genki1_vocab＿screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kanji Flashcard App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Kanji Flashcards!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FlashcardScreen()),
                  );
                },
                child: const Text('Study Kanji'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  );
                },
                child: const Text('Take Quiz'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuizScreenKunyomi()),
                  );
                },
                child: const Text('JPN Reading Quiz'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuizVocabularyScreen()),
                  );
                },
                child: const Text('Vocab Quiz'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GenkiVocabQuizScreen()),
                  );
                },
                child: Text('Genki Vocabulary Quiz'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
                child: const Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
