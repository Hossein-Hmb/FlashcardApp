import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const KanjiFlashcardApp());
}

class KanjiFlashcardApp extends StatelessWidget {
  const KanjiFlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: const TextTheme(
          headlineSmall: titleTextStyle,
          titleMedium: subtitleTextStyle,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: primaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const HomeScreen(), // Set the initial screen to HomeScreen
      debugShowCheckedModeBanner: false,
    );
  }
}
