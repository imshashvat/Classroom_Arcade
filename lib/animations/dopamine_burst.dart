import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class DopamineBurst extends StatelessWidget {
  final ConfettiController controller;

  DopamineBurst({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: controller,
      blastDirectionality: BlastDirectionality.explosive,
      colors: [Colors.pink, Colors.blue, Colors.yellow],
      numberOfParticles: 20,
    );
  }
}