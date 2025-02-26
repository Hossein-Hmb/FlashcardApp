import 'package:flutter/material.dart';

/// Colors
const Color primaryColor = Color(0xFF6200EE); // Purple
const Color accentColor = Color(0xFF03DAC5); // Teal
const Color correctAnswerColor = Colors.green;
const Color incorrectAnswerColor = Colors.red;
const Color backgroundColor = Colors.white;
const Color textColor = Colors.black;

/// Padding and Margins
const double defaultPadding = 16.0;
const double cardPadding = 12.0;
const double buttonPadding = 8.0;

/// Text Styles
const TextStyle titleTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: textColor,
);

const TextStyle kanjiTextStyle = TextStyle(
  fontSize: 60,
  fontWeight: FontWeight.bold,
  color: textColor,
);

const TextStyle subtitleTextStyle = TextStyle(
  fontSize: 18,
  color: textColor,
);

const TextStyle hintTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.grey,
);

/// Strings
const String appTitle = 'Kanji Flashcard App';
const String studyButtonText = 'Study Kanji';
const String quizButtonText = 'Take Quiz';
const String settingsButtonText = 'Settings';
const String saveSettingsText = 'Save Settings';
const String showHintsLabel = 'Show Hints';
const String shuffleCardsLabel = 'Shuffle Cards';

/// Levels
const List<String> jlptLevels = ['N5', 'N4', 'N3', 'N2', 'N1'];
