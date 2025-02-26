import 'package:flutter/material.dart';
import '../models/kanji_card.dart';
import '../utils/constants.dart';

class FlipCardWidget extends StatefulWidget {
  final KanjiCard kanjiCard;

  const FlipCardWidget({
    super.key,
    required this.kanjiCard,
  });

  @override
  FlipCardWidgetState createState() => FlipCardWidgetState();
}

class FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isFlipped = _animation.value >= 0.5;
          final angle = isFlipped ? 3.14159 : 0.0;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isFlipped ? _buildBackSide() : _buildFrontSide(),
          );
        },
      ),
    );
  }

  Widget _buildFrontSide() {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: Text(
            widget.kanjiCard.kanji,
            style: kanjiTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildBackSide() {
    return Card(
      color: accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Meaning: ${widget.kanjiCard.meaning}',
              style: subtitleTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              'Onyomi: ${widget.kanjiCard.onyomi}',
              style: hintTextStyle,
            ),
            Text(
              'Kunyomi: ${widget.kanjiCard.kunyomi}',
              style: hintTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
