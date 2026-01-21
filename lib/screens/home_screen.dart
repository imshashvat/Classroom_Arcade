import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher_sos_app/services/game_generator_service.dart';
import 'package:teacher_sos_app/services/tts_service.dart';
import 'package:teacher_sos_app/screens/battle_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  final GameGeneratorService _gameService = GameGeneratorService();
  final TtsService _ttsService = TtsService();
  String _selectedSubject = 'Science';
  String _selectedMode = 'Relay';
  String _selectedLevel = 'Easy';
  Map<String, dynamic>? _generatedGame;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true);
    _pulseAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_pulseController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CLASSROOM ARCADE 🎮')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.pinkAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(seconds: 2),
                  child: Card(
                    color: Colors.redAccent.withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '🎯 3-Minute Attention Cliff: Kids fidget after 3 mins—wired for games! Fix: Dopamine hits every 30 secs.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyan, width: 3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text('🎮 SUBJECT',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          DropdownButton<String>(
                            value: _selectedSubject,
                            items: [
                              'Science',
                              'Math',
                              'Hindi',
                              'English',
                              'EVS',
                              'Social Studies'
                            ]
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedSubject = v!),
                          ),
                          Text('GAME MODE',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          DropdownButton<String>(
                            value: _selectedMode,
                            items: [
                              'Relay',
                              'Survival',
                              'Treasure Hunt',
                              'Simon Says',
                              'Tic-Tac-Toe',
                              'Chain Reaction',
                              'Beat Teacher',
                              'Space Invaders'
                            ]
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedMode = v!),
                          ),
                          Text('DIFFICULTY',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          DropdownButton<String>(
                            value: _selectedLevel,
                            items: ['Easy', 'Medium', 'Hard']
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedLevel = v!),
                          ),
                          SizedBox(height: 10),
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) => Transform.scale(
                              scale: _pulseAnimation.value,
                              child: ElevatedButton(
                                onPressed: _generateBattle,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent),
                                child: Text('GENERATE BATTLE!',
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (_generatedGame != null) ...[
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(_generatedGame!['title'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan)),
                          Text(
                              '⏱️ ${_generatedGame!['duration']} | 👥 40 players | ⚡ 92% success',
                              style: TextStyle(color: Colors.green)),
                          Text('📋 LIVE INSTRUCTIONS:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          ...(_generatedGame!['instructions'] as List<String>)
                              .map((inst) => Text('• $inst')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _ttsService.speak(
                                    _generatedGame!['instructions'].join('. ')),
                                icon: Icon(Icons.volume_up),
                                label: Text('🔊 VOICE BRIEFING'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BattleScreen(
                                            game: _generatedGame!))),
                                child: Text('⚡ LAUNCH BATTLE'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _generateBattle() async {
    setState(() => _generatedGame = null);
    final game = await _gameService.generateGame(
        _selectedSubject, _selectedMode, _selectedLevel);
    setState(() => _generatedGame = game);
  }
}
