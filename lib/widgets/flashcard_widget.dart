import 'package:flutter/material.dart';
import '../models/kanji_card.dart';
import '../utils/constants.dart';

class FlashcardWidget extends StatefulWidget {
  final KanjiCard kanjiCard;

  const FlashcardWidget({
    super.key,
    required this.kanjiCard,
  });

  @override
  FlashcardWidgetState createState() => FlashcardWidgetState();
}

class FlashcardWidgetState extends State<FlashcardWidget> {
  bool showDetails = false; // Toggle state to show/hide details

  @override
  void didUpdateWidget(FlashcardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.kanjiCard != widget.kanjiCard) {
      showDetails = false; // Reset showDetails when a new kanjiCard is provided
    }
  }

  void _toggleDetails() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 4,
      margin: const EdgeInsets.all(cardPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Kanji Character Display
            Text(
              widget.kanjiCard.kanji,
              style: kanjiTextStyle,
            ),
            const SizedBox(height: 20),
            // Show or Hide Details
            if (showDetails) ...[
              Text('Meaning: ${widget.kanjiCard.meaning}',
                  style: subtitleTextStyle),
              const SizedBox(height: 10),
              // Updated to use onyomi as a single string
              Text('Onyomi: ${widget.kanjiCard.onyomi}', style: hintTextStyle),
              // Updated to use kunyomi as a single string
              Text('Kunyomi: ${widget.kanjiCard.kunyomi}',
                  style: hintTextStyle),
              const SizedBox(height: 10),
              Text('Examples:',
                  style:
                      subtitleTextStyle.copyWith(fontWeight: FontWeight.bold)),
              for (var example in widget.kanjiCard.examples)
                Text(example, style: hintTextStyle),
            ],
            const SizedBox(height: 20),
            // Toggle Button
            ElevatedButton(
              onPressed: _toggleDetails,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: buttonPadding, horizontal: defaultPadding),
                backgroundColor: primaryColor,
              ),
              child: Text(showDetails ? 'Hide Details' : 'Show Details'),
            ),
          ],
        ),
      ),
    );
  }
}
