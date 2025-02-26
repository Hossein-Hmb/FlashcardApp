import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ScoreTracker extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScoreTracker({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (totalQuestions > 0) ? score / totalQuestions : 0;

    return Column(
      children: [
        Text(
          'Score: $score / $totalQuestions',
          style: subtitleTextStyle,
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          color: correctAnswerColor,
        ),
      ],
    );
  }
}
