import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:teacher_sos_app/animations/dopamine_burst.dart';
import 'package:teacher_sos_app/widgets/team_badge.dart';

class BattleScreen extends StatefulWidget {
  final Map<String, dynamic> game;
  BattleScreen({required this.game});

  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _shakeController;
  Map<String, int> scores = {'Lion': 15, 'King': 12, 'Cobra': 18, 'Eagle': 10};
  int countdown = 30;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    _shakeController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DopamineBurst(controller: _confettiController),
          AnimatedBuilder(
            animation: _shakeController,
            builder: (context, child) => Transform.translate(
              offset: Offset(_shakeController.value * 10, 0),
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.purple])),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('[TEAM SCORES]', style: TextStyle(color: Colors.white, fontSize: 18)),
                      ...scores.entries.map((e) => AnimatedContainer(
                        duration: Duration(seconds: 1),
                        width: e.value * 10.0,
                        height: 20,
                        color: Colors.green,
                        child: Text('${e.key}: ${e.value}', style: TextStyle(color: Colors.white)),
                      )),
                      SizedBox(height: 20),
                      Text('NEXT ROUND: "2×7=?"', style: TextStyle(color: Colors.cyan, fontSize: 16)),
                      Text('VOICE COUNTDOWN: $countdown seconds left...', style: TextStyle(color: Colors.white)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TeamBadge(name: 'Lion', icon: Icons.looks_one),
                          TeamBadge(name: 'King', icon: Icons.looks_two),
                        ],
                      ),
                      ElevatedButton(onPressed: () => _confettiController.play(), child: Text('WIN! (Dopamine Burst)')),
                      ElevatedButton(onPressed: () => _shakeController.forward(from: 0), child: Text('ELIMINATION! (Shake)')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}