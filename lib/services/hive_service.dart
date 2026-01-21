import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static late Box _responseBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _responseBox = await Hive.openBox('responses');
  }

  static void preloadResponses() {
    _responseBox.put('relay', {
      'title': 'RELAY BATTLE 🏃‍♂️💨',
      'steps': ['4 teams: Lion/King/Cobra/Eagle', 'Solve question → Run tag next', 'Wrong → 5 jumps', 'Victory: Loser jumps!']
    });
    _responseBox.put('survival', {
      'title': 'SURVIVAL ARENA ⚔️',
      'steps': ['Grid formation', 'Living=JUMP, Non-living=FREEZE', 'Wrong=OUT', 'Last 3=Champions']
    });
    _responseBox.put('treasure', {
      'title': 'TREASURE HUNT PVP 🗺️💎',
      'steps': ['Poem split 4 ways', 'Sprint to board, write line', 'Wrong=penalty lap', 'First complete=winners']
    });
    _responseBox.put('simon', {
      'title': 'SIMON SAYS EVOLUTION 🧠',
      'steps': ['Simon says: Touch NOSE!', 'Simon says: Say HELLO!', 'Jump! (eliminated)', '5 winners become captains']
    });
    _responseBox.put('tictactoe', {
      'title': 'HUMAN TIC-TAC-TOE ⭕❌',
      'steps': ['Clean=X, Dirty=O', 'Grid on floor', 'Teacher calls "Plastic bag!" → Dirty runs to O', 'First 3-in-row wins']
    });
    _responseBox.put('chain', {
      'title': 'CHAIN REACTION ⛓️💥',
      'steps': ['Gandhi → tags Nehru', 'Wrong connection=FREEZE', 'Last kid standing=History Master']
    });
    _responseBox.put('beat', {
      'title': 'BEAT THE TEACHER 👨‍🏫⚡',
      'steps': ['Teacher asks "2+3=?"', 'First 5 correct=STEAL points', 'Class wins=Teacher dances!']
    });
    _responseBox.put('space', {
      'title': 'SPACE INVADERS MATH 👽',
      'steps': ['Kids=spaceships in grid', 'Teacher="Row 2, 6×7=?"', 'Wrong=LASER OUT', 'Last spaceship wins galaxy']
    });
    _responseBox.put('disengaged', {'text': 'Try pair-share: Pair kids, give a 1-min prompt to discuss.'});
    _responseBox.put('noise', {'text': 'Use a quiet signal: Raise hand, then start a group activity.'});
    _responseBox.put('confusion', {'text': 'Break it down: Use drawings or props for the concept.'});
  }

  static Map<String, dynamic> getResponse(String scenario) {
    return _responseBox.get(scenario) ?? {'text': 'Default tip for $scenario'};
  }

  static void logFeedback(bool positive, String scenario) {
    _responseBox.put('feedback_${DateTime.now().millisecondsSinceEpoch}', {'positive': positive, 'scenario': scenario});
  }
}