import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String selectedLevel = 'N5'; // Default JLPT level
  bool showHints = true; // Default hint setting
  bool shuffleCards = true; // Option to shuffle cards

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select JLPT Level',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedLevel,
              items: ['N5', 'N4', 'N3', 'N2', 'N1'].map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedLevel = value!;
                });
              },
            ),
            const Divider(height: 30, thickness: 1),
            SwitchListTile(
              title: const Text('Show Hints'),
              subtitle: const Text('Enable hints for kanji readings'),
              value: showHints,
              onChanged: (bool value) {
                setState(() {
                  showHints = value;
                });
              },
            ),
            const Divider(height: 30, thickness: 1),
            SwitchListTile(
              title: const Text('Shuffle Cards'),
              subtitle: const Text('Randomize the order of flashcards'),
              value: shuffleCards,
              onChanged: (bool value) {
                setState(() {
                  shuffleCards = value;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Logic to save settings can be added here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings saved')),
                );
              },
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
